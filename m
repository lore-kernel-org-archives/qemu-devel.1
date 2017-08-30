Received: from eggs.gnu.org ([2001:4830:134:3::10]:53158)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dn1GY-0007Px-A4
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 07:34:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dn1GU-0008FU-Sp
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 07:34:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34392)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dn1GU-0008FC-ND
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 07:34:34 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <6f537126-f1a6-2159-d8f7-35d34b803dfa@redhat.com> (Thomas Huth's
	message of "Mon, 28 Aug 2017 18:10:09 +0200")
References: <20170823083901.852-1-quintela@redhat.com>
	<20170823083901.852-2-quintela@redhat.com>
	<6f537126-f1a6-2159-d8f7-35d34b803dfa@redhat.com>
Reply-To: quintela@redhat.com
Date: Wed, 30 Aug 2017 13:34:30 +0200
Message-ID: <87ziah5lx5.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 1/2] tests: Use real size for iov tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, pbonzini@redhat.com, dgilbert@redhat.com, peterx@redhat.com, Christian Borntraeger <borntraeger@de.ibm.com>, =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>

Thomas Huth <thuth@redhat.com> wrote:
> On 23.08.2017 10:39, Juan Quintela wrote:
>> We were using -1 instead of the real size because the functions check
>> what is bigger, size in bytes or the size of the iov.  Recent gcc's
>> barf at this.
>> 
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> ---
>>  tests/test-iov.c | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> While you're at it, could you maybe also adjust the comments in
> include/qemu/iov.h ? It currently says:
>
>  * It is okay to use very large value for `bytes' since we're
>  * limited by the size of the iovec anyway, provided that the
>  * buffer pointed to by buf has enough space.  One possible
>  * such "large" value is -1 (sinice size_t is unsigned),
>  * so specifying `-1' as `bytes' means 'up to the end of iovec'.

This is for the _full() versions, and still work.  the same for
iov_memset().  

> ... and apparently -1 is not working anymore as expected. Maybe SIZE_MAX
> from stdint.h is a better choice?


static inline size_t
iov_from_buf(const struct iovec *iov, unsigned int iov_cnt,
             size_t offset, const void *buf, size_t bytes)
{
    if (__builtin_constant_p(bytes) && iov_cnt &&
        offset <= iov[0].iov_len && bytes <= iov[0].iov_len - offset) {
        memcpy(iov[0].iov_base + offset, buf, bytes);
        return bytes;
    } else {
        return iov_from_buf_full(iov, iov_cnt, offset, buf, bytes);
    }
}

This optimization don't work very well if we used bytes = -1,
furthermore, we return the wrong value.

And no, I don't understand how the (bytes <= iov[0].iov_len - offset)
test pass when bytes == -1.

Later, Juan.
