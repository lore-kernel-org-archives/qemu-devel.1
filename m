Received: from eggs.gnu.org ([209.51.188.92]:49301)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1h3POO-0000Rg-DO
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 14:11:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1h3PON-0001to-Ga
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 14:11:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43360)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bsd@redhat.com>) id 1h3PON-0001sd-7T
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 14:11:15 -0400
From: Bandan Das <bsd@redhat.com>
References: <20190307095441.31921-1-kraxel@redhat.com>
	<20190307095441.31921-4-kraxel@redhat.com>
	<CAFEAcA_HzSj7sQ+aKEwHmJXkJcG8yLmn5ZsZKM5xxYUrBxO2rQ@mail.gmail.com>
	<jpg36nxf8ta.fsf@linux.bootlegged.copy>
	<jpg8sxpypx2.fsf_-_@linux.bootlegged.copy>
	<CAFEAcA_3=cQDHibDe++d+6UpkHhKMP8=s4iJYbqUVeJdDQv+fQ@mail.gmail.com>
	<jpg8sxle6c6.fsf@linux.bootlegged.copy>
	<CAFEAcA9sx64kcz=wOqeBwGg0YJc-xO-K5yNkoSC8uuCqNF_FYA@mail.gmail.com>
	<jpgef7d746o.fsf@linux.bootlegged.copy>
	<CAFEAcA_U=1w2krP9zrC3oXjhJZ1Y5k+2GP_s3oY0p8WvB_9hig@mail.gmail.com>
	<jpgzhq1cnuc.fsf@linux.bootlegged.copy>
	<CAFEAcA_xQ=Y0HVkb+qDTmuf8p02UiAp5UKbbjPthy-vTv+SyXA@mail.gmail.com>
Date: Mon, 11 Mar 2019 14:11:09 -0400
In-Reply-To: <CAFEAcA_xQ=Y0HVkb+qDTmuf8p02UiAp5UKbbjPthy-vTv+SyXA@mail.gmail.com>
	(Peter Maydell's message of "Mon, 11 Mar 2019 17:55:09 +0000")
Message-ID: <jpga7i1uvr6.fsf@linux.bootlegged.copy>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] usb-mtp: fix return status of delete
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Gerd Hoffmann <kraxel@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> writes:
...
>> >
>> >> > It might be useful to take a step back -- what are
>> >> > the different possible outcomes from this function that
>> >> > we need to distinguish, and when should we be returning
>> >> > which outcome?
>> >
>> They are what the variable names signify.
>
> That doesn't get me any further forward, I'm afraid.
>
> Looking at the code, we seem to have:
>  * for any particular node, either we can delete it
>    or we can't
>  * we also iterate through each child node recursively
>
> So we have to combine together the "deleted this"
> and "failed to delete this" information for the whole tree.
> In which conditions should we end up with which RES_*
> result code? It seems plausible that we want RES_OK
> only if every deletion attempt in the tree succeeded.
> But what about the others? Is it supposed to be
> RES_PARTIAL_DELETE if some deletions succeeded and
> some failed, and RES_STORE_READ_ONLY if every single
> deletion failed ?
>
Ok, this is easier. Now, I know what you are referring to
instead of guessing what and how I should be explainng.

What you said is essentially correct. When deleting a
single object that's a file, the return value would either
be OK or STORE_READ_ONLY.

When deleting an object which is a folder, Qemu goes through
its contents. If it succeeds in deleting all the content objects,
the result is success. If one or some objects couldn't be deleted for
whatever reason, the result is RES_PARTIAL_DELETE and if none
of the objects could be deleted, Qemu returns a READ_ONLY.

In usb_mtp_object_delete(), based on the return value of this
function, we set s->result appropriately.

> thanks
> -- PMM
