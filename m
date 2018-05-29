Received: from eggs.gnu.org ([2001:4830:134:3::10]:46948)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1fNjHy-0003BY-AH
	for qemu-devel@nongnu.org; Tue, 29 May 2018 14:24:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1fNjHt-0006Ds-B2
	for qemu-devel@nongnu.org; Tue, 29 May 2018 14:24:06 -0400
Received: from mail-io0-x242.google.com ([2607:f8b0:4001:c06::242]:37530)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1fNjHt-0006DL-3S
	for qemu-devel@nongnu.org; Tue, 29 May 2018 14:24:01 -0400
Received: by mail-io0-x242.google.com with SMTP id e20-v6so18747869iof.4
	for <qemu-devel@nongnu.org>; Tue, 29 May 2018 11:24:01 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <20180529181523.19185-1-peter.maydell@linaro.org>
Date: Tue, 29 May 2018 14:23:58 -0400
Content-Transfer-Encoding: quoted-printable
Message-Id: <F7609DAE-0BEF-4384-BB0A-570B8BF4EFE7@gmail.com>
References: <20180529181523.19185-1-peter.maydell@linaro.org>
Subject: Re: [Qemu-devel] [PATCH v2] ui/cocoa: Suppress
 NSFileHandlingPanelOKButton deprecation warning
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, patches@linaro.org


> On May 29, 2018, at 2:15 PM, Peter Maydell <peter.maydell@linaro.org> =
wrote:
>=20
> OSX 10.13 deprecates the NSFileHandlingPanelOKButton constant, and
> would rather you use NSModalResponseOK, which was introduced in OS =
10.9.
> Use the recommended new constant name, with a backward compatibility
> define if we're building on an older OSX.
>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> v1->v2: define MAC_OS_X_VERSION_10_9 if the system headers don't;
> fixes compilation on versions before 10.9.
> ---
> ui/cocoa.m | 12 +++++++++++-
> 1 file changed, 11 insertions(+), 1 deletion(-)
>=20
> diff --git a/ui/cocoa.m b/ui/cocoa.m
> index 110b393e4e..2991ed4f19 100644
> --- a/ui/cocoa.m
> +++ b/ui/cocoa.m
> @@ -44,6 +44,9 @@
> #ifndef MAC_OS_X_VERSION_10_6
> #define MAC_OS_X_VERSION_10_6 1060
> #endif
> +#ifndef MAC_OS_X_VERSION_10_9
> +#define MAC_OS_X_VERSION_10_9 1090
> +#endif
> #ifndef MAC_OS_X_VERSION_10_10
> #define MAC_OS_X_VERSION_10_10 101000
> #endif
> @@ -79,6 +82,13 @@
> #define NSWindowStyleMaskMiniaturizable NSMiniaturizableWindowMask
> #define NSWindowStyleMaskTitled         NSTitledWindowMask
> #endif
> +/* 10.13 deprecates NSFileHandlingPanelOKButton in favour of
> + * NSModalResponseOK, which was introduced in 10.9. Define
> + * it for older versions.
> + */
> +#if MAC_OS_X_VERSION_MAX_ALLOWED < MAC_OS_X_VERSION_10_9
> +#define NSModalResponseOK NSFileHandlingPanelOKButton
> +#endif
>=20
> //#define DEBUG
>=20
> @@ -1218,7 +1228,7 @@ QemuCocoaView *cocoaView;
>     [openPanel setCanChooseFiles: YES];
>     [openPanel setAllowsMultipleSelection: NO];
>     [openPanel setAllowedFileTypes: supportedImageFileTypes];
> -    if([openPanel runModal] =3D=3D NSFileHandlingPanelOKButton) {
> +    if([openPanel runModal] =3D=3D NSModalResponseOK) {
>         NSString * file =3D [[[openPanel URLs] objectAtIndex: 0] =
path];
>         if(file =3D=3D nil) {
>             NSBeep();
> --=20
> 2.17.0
>=20

It works :)

Reviewed-by: John Arbuckle <programmingkidx@gmail.com>
