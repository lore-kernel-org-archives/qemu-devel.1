Received: from eggs.gnu.org ([2001:4830:134:3::10]:49876)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1gJf8s-0005xt-HQ
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 08:42:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1gJezw-0007ic-Ih
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 08:32:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35750)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1gJezw-0007ZS-3a
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 08:32:56 -0500
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20181101101715.9443-2-fli@suse.com> (Fei Li's message of "Thu, 1
	Nov 2018 18:17:07 +0800")
References: <20181101101715.9443-1-fli@suse.com>
	<20181101101715.9443-2-fli@suse.com>
Reply-To: quintela@redhat.com
Date: Mon, 05 Nov 2018 14:32:42 +0100
Message-ID: <87h8gvvedh.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH RFC v7 1/9] Fix segmentation fault when
 qemu_signal_init fails
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fei Li <fli@suse.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, dgilbert@redhat.com, famz@redhat.com, peterx@redhat.com

Fei Li <fli@suse.com> wrote:
> When qemu_signal_init() fails in qemu_init_main_loop(), we return
> without setting an error.  Its callers crash then when they try to
> report the error with error_report_err().
>
> To avoid such segmentation fault, add a new Error parameter to make
> the call trace to propagate the err to the final caller.

Hi

I agree that there is a bug that exist here.  But I think that the patch
is not 100% correct.  What is the warrantee that when we call
qemu_signal_init() errp is not *already* assigned.

I think that we need to use here the same code that in the call to
aio_context_new() ...

i.e.


intsead of this

>      init_clocks(qemu_timer_notify_cb);
>  
> -    ret = qemu_signal_init();
> +    ret = qemu_signal_init(errp);
>      if (ret) {
>          return ret;
>      }

    init_clocks(qemu_timer_notify_cb);

    ret = qemu_signal_init();
    ret = qemu_signal_init(&local_error);
    if (ret) {
         error_propagate(errp, local_error);
         return ret;
    }

This way it works correctly if errp is NULL, errp is already assigned,
etc, etc,

Or I am missing something?

Later, Juan.
