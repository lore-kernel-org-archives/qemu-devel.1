Received: from eggs.gnu.org ([2001:4830:134:3::10]:33940)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cYDaw-0006k0-Td
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 10:10:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cYDav-0004Kz-QA
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 10:10:14 -0500
Received: from mail-vk0-x233.google.com ([2607:f8b0:400c:c05::233]:33276)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cYDav-0004Ko-Ks
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 10:10:13 -0500
Received: by mail-vk0-x233.google.com with SMTP id k127so216876212vke.0
	for <qemu-devel@nongnu.org>; Mon, 30 Jan 2017 07:10:13 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1485787271-8754-1-git-send-email-ashijeetacharya@gmail.com>
References: <1485787271-8754-1-git-send-email-ashijeetacharya@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 30 Jan 2017 15:09:52 +0000
Message-ID: <CAFEAcA_tGGVL2aP5Gu5ZyX3KKVTA_gFa4wtSxAhJrjAKQZiOLw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH] migrate: Introduce a 'dc->vmsd' check to
 avoid segfault for --only-migratable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ashijeet Acharya <ashijeetacharya@gmail.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Amit Shah <amit.shah@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Juan Quintela <quintela@redhat.com>

On 30 January 2017 at 14:41, Ashijeet Acharya <ashijeetacharya@gmail.com> wrote:
> Commit a3a3d8c7 introduced a segfault bug while checking for
> 'dc->vmsd->unmigratable' which caused QEMU to crash when trying to add
> devices which do no set their 'dc->vmsd' yet while initialization.
> Place a 'dc->vmsd' check prior to it so that we do not segfault for
> such devices.
>
> NOTE: This doesn't compromise the functioning of --only-migratable
> option as all the unmigratable devices do set their 'dc->vmsd'.
>
> Signed-off-by: Ashijeet Acharya <ashijeetacharya@gmail.com>
> ---
>  qdev-monitor.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/qdev-monitor.c b/qdev-monitor.c
> index 81d01df..a1106fd 100644
> --- a/qdev-monitor.c
> +++ b/qdev-monitor.c
> @@ -578,7 +578,7 @@ DeviceState *qdev_device_add(QemuOpts *opts, Error **errp)
>          return NULL;
>      }
>
> -    if (only_migratable) {
> +    if (only_migratable && dc->vmsd) {
>          if (dc->vmsd->unmigratable) {
>              error_setg(errp, "Device %s is not migratable, but "
>                         "--only-migratable was specified", driver);

This seems like a good fix for the crash as a short term fix,
but longer term I think it would be better to make setting
dc->vmsd mandatory. I think devices which don't set it fall into
one of these categories:
 * deliberately has no VMState struct as it has no state that
   needs migrating -- we should have some kind of flag for
   such devices to positively assert that they don't need to
   deal with migration
 * accidentally failed to provide a VMState struct -- this is
   a bug and the device should be fixed to at minimum mark
   itself as unmigratable (and ideally fixed to implement
   migration!)
 * didn't provide a VMState struct because they handle
   migration manually using vmstate_register() -- we should
   update these to use VMState, or failing that use the
   flag to say "deliberately not providing VMState"

Then we can make QEMU assert if dc->vmsd is NULL, and
catch future occurrences of "oops I didn't think about
migration" bugs in new device models. We also have an
easy way to grep the codebase for devices that need to
have migration implemented.

thanks
-- PMM
