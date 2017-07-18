Received: from eggs.gnu.org ([2001:4830:134:3::10]:42312)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dXPnJ-0003y6-1V
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 06:31:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dXPnE-0005FV-3E
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 06:31:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45336)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dXPnD-0005FD-QR
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 06:31:52 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <1a32d619-0b5b-fe11-36b4-94ef6bdcb331@linux.vnet.ibm.com> (Halil
	Pasic's message of "Thu, 13 Jul 2017 17:45:28 +0200")
References: <1499942429-55449-1-git-send-email-borntraeger@de.ibm.com>
	<1499942429-55449-4-git-send-email-borntraeger@de.ibm.com>
	<20170713142721.3a40e083@gondolin>
	<1798a9f2-63f0-ab03-11ad-5513d9a90da9@linux.vnet.ibm.com>
	<20170713144941.GD2121@work-vm>
	<99be1408-f8e4-7ecb-f47e-9de94a20ff18@de.ibm.com>
	<20170713151104.GE2121@work-vm>
	<1a32d619-0b5b-fe11-36b4-94ef6bdcb331@linux.vnet.ibm.com>
Reply-To: quintela@redhat.com
Date: Tue, 18 Jul 2017 12:31:47 +0200
Message-ID: <87379uyr1o.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH/s390-next 3/3] s390x/flic: migrate ais
 states
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Yi Min Zhao <zyimin@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, Thomas Huth <thuth@redhat.com>, Richard Henderson <rth@twiddle.net>

Halil Pasic <pasic@linux.vnet.ibm.com> wrote:
> On 07/13/2017 05:11 PM, Dr. David Alan Gilbert wrote:
>> * Christian Borntraeger (borntraeger@de.ibm.com) wrote:
>>> On 07/13/2017 04:49 PM, Dr. David Alan Gilbert wrote:
>>>> * Halil Pasic (pasic@linux.vnet.ibm.com) wrote:

> @Dave:
> There are a couple of questions I'm gonna have to ask/investigate should
> it be me doing the 'return value for pre_save' (also notes to myself):

As Dave said, just changing the prototype and fix callers will do a lot
of good.

> (keep the current qemu_file_set_error mechanism) or would you prefer
> things converted? IMHO having a single method would be cleaner, but I
> have not looked into this in great detail.

Error handling is a mess in qemu (in general), and worse in migration
(in particular).

History lesson (that is even older than my involvement with qemu)

It used to be that evrything was done with callbacks in the main loop.
So there were not an easy way to pass error messages.  Everything was
done through qemu_file_set_error() (well, actually it was done by hand).

Then the migration thread came, and we can do things asyncronously, so
we don't need to store the state in callbacks.  I did some changes long,
long ago about returning  error messages instead of:

if (error) {
   qemu_file_set_error(f, -error);
   return;
}

to

if (error) {
    return -error;
}

/* fix things to make errors negative, etc, etc, you get the idea */

But we need to fix some things to make this work.

Reception side is done through a coroutine, and then some of such things
still stand.  Moving to a thread would be a good idea at some point O:-)

> Also the question what is the semantic of qemu_file_set_error arises.
> It ain't documented and I would intuitively suspect that it's rather
> about the 'file' (that is transport) than the whole migration.

We test in the "interesting" parts if there is an error on the file,

from vmstate_load_state()

                } else {
                    ret = field->info->get(f, curr_elem, size, field);
                }
                if (ret >= 0) {
                    ret = qemu_file_get_error(f);
                }
                if (ret < 0) {
                    qemu_file_set_error(f, ret);
                    error_report("Failed to load %s:%s", vmsd->name,
                                 field->name);
                    trace_vmstate_load_field_error(field->name, ret);
                    return ret;
                }


You can see how many convolutions we do to maintain the error returned
and the one in QEMUFile in sync.  Removing the one in QEMUFile would be
a good idea, but requires lots of changes.

For starters, see that all qemu_get_* return void.

To add insult to injury:

int qemu_peek_byte(QEMUFile *f, int offset)
{
    int index = f->buf_index + offset;

    assert(!qemu_file_is_writable(f));
    assert(offset < IO_BUF_SIZE);

    if (index >= f->buf_size) {
        qemu_fill_buffer(f);
        index = f->buf_index + offset;
        if (index >= f->buf_size) {
            return 0;
        }
    }
    return f->buf[index];
}

I.e. it never returns errors, if there is nothing to read, it just
return 0.

/me stops

>
>
>
>>>>
>>>>   I *think* the migration code should spot that before it finishes
>>>> but it might carry on for a little while before it does.
>>>
>>> I will keep this patch as is, since this is one of the "should not happen"
>>> cases.

Later, Juan.
