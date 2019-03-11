Received: from eggs.gnu.org ([209.51.188.92]:46703)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1h3Tw9-0002eA-9v
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 19:02:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1h3Tw8-0006vQ-9l
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 19:02:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38607)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bsd@redhat.com>) id 1h3Tw8-0006uz-0n
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 19:02:24 -0400
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
	<jpga7i1uvr6.fsf@linux.bootlegged.copy>
	<CAFEAcA_wDgYooMLotS-SmASWjRxVhTzn6eeiDgH-zVfu3=v+xA@mail.gmail.com>
Date: Mon, 11 Mar 2019 19:02:19 -0400
In-Reply-To: <CAFEAcA_wDgYooMLotS-SmASWjRxVhTzn6eeiDgH-zVfu3=v+xA@mail.gmail.com>
	(Peter Maydell's message of "Mon, 11 Mar 2019 18:56:51 +0000")
Message-ID: <jpg5zsp581w.fsf@linux.bootlegged.copy>
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
>> Ok, this is easier. Now, I know what you are referring to
>> instead of guessing what and how I should be explainng.
>>
>> What you said is essentially correct. When deleting a
>> single object that's a file, the return value would either
>> be OK or STORE_READ_ONLY.
>>
>> When deleting an object which is a folder, Qemu goes through
>> its contents. If it succeeds in deleting all the content objects,
>> the result is success. If one or some objects couldn't be deleted for
>> whatever reason, the result is RES_PARTIAL_DELETE and if none
>> of the objects could be deleted, Qemu returns a READ_ONLY.
>>
>> In usb_mtp_object_delete(), based on the return value of this
>> function, we set s->result appropriately.
>
> OK. So we can do this with a return value where the
> two relevant bits indicate:
>  * bit 0: We had at least one successful deletion
>  * bit 1: We had at least one failed deletion
>
> and then the correct RES value is:
>  * only bit 0 set: READ_ONLY
>  * only bit 1 set: OK
>  * both bits set: PARTIAL_DELETE
>  * neither bit set: can't happen
>
> This is what your patch does, I think, but you've named
> the "at least one deletion succeeded" bit "ALL_DELETE"
> (even though it can be set in a return value where not
> all of the deletions succeeded) and the "at least one
> deletion failed" bit "READ_ONLY" (even though it can
> be set in a return value where some deletions succeeded),
> which is what I found confusing.
>
> I think the code would be easier to understand if we:
>  * picked clearer names for the bits, like
>    DELETE_SUCCESS and DELETE_FAILURE
>  * had a comment explaining what the return value
>    of the function means, something like:
>
> /*
>  * Delete the object @o and all its children. In the
>  * return value, the DELETE_SUCCESS bit is set if at
>  * least one of the deletions succeeded, and the
>  * DELETE_FAILURE bit is set if at least one of the
>  * deletions failed. If the tree of objects was only
>  * partially deleted then both bits will be set.
>  */
>
> But really the second of these is the more important:
> slightly confusing naming is OK if there is a good
> comment explaining what is going on (and my suggested
> bit flag names don't really stand on their own without
> any explanation either). So if you strongly prefer your names
> for the bits that's ok, but please do add a comment,
> either at the top of the function or documenting
> the meaning of the enum values.
>
Peter, thank you for the thorough review, I really appreciate it.
I definitely want to make this code less confusing to the next
potential reviewer. I will address all your suggestions in the
next version of the patch.

Bandan

> thanks
> -- PMM
