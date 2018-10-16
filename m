Received: from eggs.gnu.org ([2001:4830:134:3::10]:48998)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gCRS9-0007BC-51
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 11:40:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gCRS8-0002Xx-8p
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 11:40:13 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20181016064141.32167-1-armbru@redhat.com>
	<20181016123907.GF5620@dhcp-200-186.str.redhat.com>
Date: Tue, 16 Oct 2018 17:40:02 +0200
In-Reply-To: <20181016123907.GF5620@dhcp-200-186.str.redhat.com> (Kevin Wolf's
	message of "Tue, 16 Oct 2018 14:39:07 +0200")
Message-ID: <87k1mhnbn1.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [RFC PATCH] block: Clean up bdrv_img_create()'s
 error reporting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com

Kevin Wolf <kwolf@redhat.com> writes:

> Am 16.10.2018 um 08:41 hat Markus Armbruster geschrieben:
>> bdrv_img_create() takes an Error ** argument and used it in the
>> conventional way, except for one place: when qemu_opts_do_parse()
>> fails, it first reports its error to stderr or the HMP monitor with
>> error_report_err(), then error_setg()'s a generic error.  When the
>> caller reports that second error similarly, this produces two
>> consecutive error messages on stderr or the HMP monitor.  When the
>> caller does something else with it, such as send it via QMP, the first
>> error still goes to stderr or the HMP monitor.  Not good.
>> 
>> Turn the first message into a prefix for the second.
>> 
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>> 
>> This is RFC because I didn't check whether "caller does something else
>> with it" can actually happen with current code, and I'm not sure the
>> prefix is wanted.  I hope we'll answer both questions during review.
>
> The only caller that passes non-NULL options and can therefore even run
> into this error path is qemu-img.c. It passes any Error it receives to
> error_reportf_err().
>
> Current behaviour:
>
>     $ ./qemu-img create -f qcow2 -o foo=bar /tmp/test.qcow2 64M
>     qemu-img: Invalid parameter 'foo'
>     qemu-img: /tmp/test.qcow2: Invalid options for file format 'qcow2'
>
> Assumed behaviour with your patch (can't test because I don't have
> error_propagate_prepend() yet and its addition is not a separate patch):

Sorry, forgot
Based-on: <20181015115309.17089-1-armbru@redhat.com>

Don't bother testing, my patch is buggy.

>     $ ./qemu-img create -f qcow2 -o foo=bar /tmp/test.qcow2 64M
>     qemu-img: /tmp/test.qcow2: Invalid options for file format 'qcow2': Invalid parameter 'foo'
>
> Combining two redundant messages into a single line is nice. Keeping
> the redundant information in it ('invalid options'/'invalid parameter')
> isn't perfect, though.
>
> If instead of prepending, we just propagate the error, would this
> actually lack any important information?
>
>     $ ./qemu-img create -f qcow2 -o foo=bar /tmp/test.qcow2 64M
>     qemu-img: /tmp/test.qcow2: Invalid parameter 'foo'

Works for me.  Thanks!
