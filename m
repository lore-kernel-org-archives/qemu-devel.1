Received: from eggs.gnu.org ([209.51.188.92]:59059)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h3QHm-00032i-CZ
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 15:08:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h3Q6k-00014u-J4
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 14:57:07 -0400
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a]:42117)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1h3Q6k-00013o-BJ
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 14:57:06 -0400
Received: by mail-oi1-x22a.google.com with SMTP id s16so4554560oih.9
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 11:57:04 -0700 (PDT)
MIME-Version: 1.0
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
In-Reply-To: <jpga7i1uvr6.fsf@linux.bootlegged.copy>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 11 Mar 2019 18:56:51 +0000
Message-ID: <CAFEAcA_wDgYooMLotS-SmASWjRxVhTzn6eeiDgH-zVfu3=v+xA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] usb-mtp: fix return status of delete
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bandan Das <bsd@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On Mon, 11 Mar 2019 at 18:11, Bandan Das <bsd@redhat.com> wrote:
>
> Peter Maydell <peter.maydell@linaro.org> writes:
> > Looking at the code, we seem to have:
> >  * for any particular node, either we can delete it
> >    or we can't
> >  * we also iterate through each child node recursively
> >
> > So we have to combine together the "deleted this"
> > and "failed to delete this" information for the whole tree.
> > In which conditions should we end up with which RES_*
> > result code? It seems plausible that we want RES_OK
> > only if every deletion attempt in the tree succeeded.
> > But what about the others? Is it supposed to be
> > RES_PARTIAL_DELETE if some deletions succeeded and
> > some failed, and RES_STORE_READ_ONLY if every single
> > deletion failed ?
> >
> Ok, this is easier. Now, I know what you are referring to
> instead of guessing what and how I should be explainng.
>
> What you said is essentially correct. When deleting a
> single object that's a file, the return value would either
> be OK or STORE_READ_ONLY.
>
> When deleting an object which is a folder, Qemu goes through
> its contents. If it succeeds in deleting all the content objects,
> the result is success. If one or some objects couldn't be deleted for
> whatever reason, the result is RES_PARTIAL_DELETE and if none
> of the objects could be deleted, Qemu returns a READ_ONLY.
>
> In usb_mtp_object_delete(), based on the return value of this
> function, we set s->result appropriately.

OK. So we can do this with a return value where the
two relevant bits indicate:
 * bit 0: We had at least one successful deletion
 * bit 1: We had at least one failed deletion

and then the correct RES value is:
 * only bit 0 set: READ_ONLY
 * only bit 1 set: OK
 * both bits set: PARTIAL_DELETE
 * neither bit set: can't happen

This is what your patch does, I think, but you've named
the "at least one deletion succeeded" bit "ALL_DELETE"
(even though it can be set in a return value where not
all of the deletions succeeded) and the "at least one
deletion failed" bit "READ_ONLY" (even though it can
be set in a return value where some deletions succeeded),
which is what I found confusing.

I think the code would be easier to understand if we:
 * picked clearer names for the bits, like
   DELETE_SUCCESS and DELETE_FAILURE
 * had a comment explaining what the return value
   of the function means, something like:

/*
 * Delete the object @o and all its children. In the
 * return value, the DELETE_SUCCESS bit is set if at
 * least one of the deletions succeeded, and the
 * DELETE_FAILURE bit is set if at least one of the
 * deletions failed. If the tree of objects was only
 * partially deleted then both bits will be set.
 */

But really the second of these is the more important:
slightly confusing naming is OK if there is a good
comment explaining what is going on (and my suggested
bit flag names don't really stand on their own without
any explanation either). So if you strongly prefer your names
for the bits that's ok, but please do add a comment,
either at the top of the function or documenting
the meaning of the enum values.

thanks
-- PMM
