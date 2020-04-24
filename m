Return-Path: <SRS0=J7/p=6I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38D04C54FD0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 13:22:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0062220767
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 13:22:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dpfJHXUJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0062220767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36912 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRyHc-0006Ac-3L
	for qemu-devel@archiver.kernel.org; Fri, 24 Apr 2020 09:22:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53912)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jag.raman@oracle.com>) id 1jRyGu-0005Zt-RA
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 09:21:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <jag.raman@oracle.com>) id 1jRyGt-0004su-SE
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 09:21:36 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:48780)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1jRyGt-0004sV-9F
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 09:21:35 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03ODId71072555;
 Fri, 24 Apr 2020 13:21:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=XkNbRblOH6CyMFzWG+aDklpkoEO8eWM0dSjNI8/Rl7I=;
 b=dpfJHXUJCACs2w9zcTwOeMP5UBBgU3Lj0idr8R23qdI55QXHR54BmW8f+gHPaJtyK3KW
 o6H+hq9+BwKv4mVGZVu25VtGxchJAxWnxAiOKkS/Bvm8pwOyITqmLgQCaPR0l3Dh8yVE
 lcJ6dnrGbfmRIZSARMqcSgwbbwFSr/uAAnHWvVCrvje5pJ9tZAY/wBOLaUCghk7mwX+f
 Td2C42UBU/w8yDq3ViXE2/scFTK4wZPtHwRiyr194dr8/AYOLX3bdgyOzDysOc8WoT2k
 bkG3OICN2M76UJLBXTsgEPDB7zq2OcKhlzJpX+w/pbfiCybTPilg5fIaG6IDO7VwWQ8t Yg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by aserp2120.oracle.com with ESMTP id 30jvq5120k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 24 Apr 2020 13:21:33 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03ODGfXq182004;
 Fri, 24 Apr 2020 13:19:33 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by aserp3020.oracle.com with ESMTP id 30gbbq5ef4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 24 Apr 2020 13:19:33 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 03ODJWoQ023264;
 Fri, 24 Apr 2020 13:19:32 GMT
Received: from dhcp-10-39-221-180.vpn.oracle.com (/10.39.221.180)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Fri, 24 Apr 2020 06:19:32 -0700
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [PATCH 5/7] chardev: Extract system emulation specific code
From: Jag Raman <jag.raman@oracle.com>
In-Reply-To: <20200423202112.644-6-philmd@redhat.com>
Date: Fri, 24 Apr 2020 09:19:30 -0400
Content-Transfer-Encoding: quoted-printable
Message-Id: <3576CF15-BE7D-4ED4-AC3B-56806D17A2B5@oracle.com>
References: <20200423202112.644-1-philmd@redhat.com>
 <20200423202112.644-6-philmd@redhat.com>
To: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@redhat.com>
X-Mailer: Apple Mail (2.3445.9.1)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9600
 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0
 suspectscore=3 mlxlogscore=999 adultscore=0 mlxscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004240106
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9600
 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 malwarescore=0
 mlxscore=0 adultscore=0 mlxlogscore=999 phishscore=0 impostorscore=0
 clxscore=1011 bulkscore=0 spamscore=0 priorityscore=1501 suspectscore=3
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004240106
Received-SPF: pass client-ip=141.146.126.78; envelope-from=jag.raman@oracle.com;
 helo=aserp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/24 09:21:34
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Received-From: 141.146.126.78
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 John G Johnson <john.g.johnson@oracle.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> On Apr 23, 2020, at 4:21 PM, Philippe Mathieu-Daud=C3=A9 =
<philmd@redhat.com> wrote:
>=20
> Split out code only used during system emulation,
> to reduce code pulled in user emulation and tools.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
> chardev/chardev-internal.h |  3 ++
> chardev/char.c             | 35 +------------------
> chardev/chardev-sysemu.c   | 69 ++++++++++++++++++++++++++++++++++++++
> chardev/Makefile.objs      |  1 +
> 4 files changed, 74 insertions(+), 34 deletions(-)
> create mode 100644 chardev/chardev-sysemu.c
>=20
> diff --git a/chardev/chardev-internal.h b/chardev/chardev-internal.h
> index e0264ac349..f4d0429763 100644
> --- a/chardev/chardev-internal.h
> +++ b/chardev/chardev-internal.h
> @@ -26,6 +26,7 @@
>=20
> #include "chardev/char.h"
> #include "chardev/char-fe.h"
> +#include "qom/object.h"
>=20
> #define MAX_MUX 4
> #define MUX_BUFFER_SIZE 32 /* Must be a power of 2.  */
> @@ -59,4 +60,6 @@ typedef struct MuxChardev {
> void mux_set_focus(Chardev *chr, int focus);
> void mux_chr_send_all_event(Chardev *chr, QEMUChrEvent event);
>=20
> +Object *get_chardevs_root(void);
> +
> #endif /* CHAR_MUX_H */
> diff --git a/chardev/char.c b/chardev/char.c
> index b672a41150..555bb0448e 100644
> --- a/chardev/char.c
> +++ b/chardev/char.c
> @@ -44,7 +44,7 @@
> /***********************************************************/
> /* character device */
>=20
> -static Object *get_chardevs_root(void)
> +Object *get_chardevs_root(void)
> {
>     return container_get(object_get_root(), "/chardevs");
> }
> @@ -300,33 +300,6 @@ static const TypeInfo char_type_info =3D {
>     .class_init =3D char_class_init,
> };
>=20
> -static int chardev_machine_done_notify_one(Object *child, void =
*opaque)
> -{
> -    Chardev *chr =3D (Chardev *)child;
> -    ChardevClass *class =3D CHARDEV_GET_CLASS(chr);
> -
> -    if (class->chr_machine_done) {
> -        return class->chr_machine_done(chr);
> -    }
> -
> -    return 0;
> -}
> -
> -static void chardev_machine_done_hook(Notifier *notifier, void =
*unused)
> -{
> -    int ret =3D object_child_foreach(get_chardevs_root(),
> -                                   chardev_machine_done_notify_one, =
NULL);
> -
> -    if (ret) {
> -        error_report("Failed to call chardev machine_done hooks");
> -        exit(1);
> -    }
> -}
> -
> -static Notifier chardev_machine_done_notify =3D {
> -    .notify =3D chardev_machine_done_hook,
> -};
> -
> static bool qemu_chr_is_busy(Chardev *s)
> {
>     if (CHARDEV_IS_MUX(s)) {
> @@ -1187,12 +1160,6 @@ void qemu_chr_cleanup(void)
> static void register_types(void)
> {
>     type_register_static(&char_type_info);
> -
> -    /* this must be done after machine init, since we register FEs =
with muxes
> -     * as part of realize functions like serial_isa_realizefn when =
-nographic
> -     * is specified
> -     */
> -    =
qemu_add_machine_init_done_notifier(&chardev_machine_done_notify);
> }
>=20
> type_init(register_types);
> diff --git a/chardev/chardev-sysemu.c b/chardev/chardev-sysemu.c
> new file mode 100644
> index 0000000000..eecdc615ee
> --- /dev/null
> +++ b/chardev/chardev-sysemu.c
> @@ -0,0 +1,69 @@
> +/*
> + * QEMU System Emulator
> + *
> + * Copyright (c) 2003-2008 Fabrice Bellard
> + *
> + * Permission is hereby granted, free of charge, to any person =
obtaining a copy
> + * of this software and associated documentation files (the =
"Software"), to deal
> + * in the Software without restriction, including without limitation =
the rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, =
and/or sell
> + * copies of the Software, and to permit persons to whom the Software =
is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be =
included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, =
EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF =
MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT =
SHALL
> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES =
OR OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, =
ARISING FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER =
DEALINGS IN
> + * THE SOFTWARE.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "sysemu/sysemu.h"
> +#include "chardev/char.h"
> +#include "qemu/error-report.h"
> +#include "chardev-internal.h"
> +
> +static int chardev_machine_done_notify_one(Object *child, void =
*opaque)
> +{
> +    Chardev *chr =3D (Chardev *)child;
> +    ChardevClass *class =3D CHARDEV_GET_CLASS(chr);
> +
> +    if (class->chr_machine_done) {
> +        return class->chr_machine_done(chr);
> +    }
> +
> +    return 0;
> +}
> +
> +static void chardev_machine_done_hook(Notifier *notifier, void =
*unused)
> +{
> +    int ret =3D object_child_foreach(get_chardevs_root(),
> +                                   chardev_machine_done_notify_one, =
NULL);
> +
> +    if (ret) {
> +        error_report("Failed to call chardev machine_done hooks");
> +        exit(1);
> +    }
> +}
> +
> +
> +static Notifier chardev_machine_done_notify =3D {
> +    .notify =3D chardev_machine_done_hook,
> +};
> +
> +static void register_types(void)
> +{
> +    /*
> +     * This must be done after machine init, since we register FEs =
with muxes
> +     * as part of realize functions like serial_isa_realizefn when =
-nographic
> +     * is specified.
> +     */
> +    =
qemu_add_machine_init_done_notifier(&chardev_machine_done_notify);
> +}
> +
> +type_init(register_types);

Could you please confirm if we could use =E2=80=9Ctype_init=E2=80=9D for =
something other
than a class?

May be the chardev machine init notified could be initialized by vl.c?

> diff --git a/chardev/Makefile.objs b/chardev/Makefile.objs
> index 15ee7f47da..a10acbc2b8 100644
> --- a/chardev/Makefile.objs
> +++ b/chardev/Makefile.objs
> @@ -1,4 +1,5 @@
> chardev-obj-y +=3D char.o
> +chardev-obj-$(CONFIG_SOFTMMU) +=3D chardev-sysemu.o
> chardev-obj-$(CONFIG_WIN32) +=3D char-console.o
> chardev-obj-$(CONFIG_POSIX) +=3D char-fd.o
> chardev-obj-y +=3D char-fe.o
> --=20
> 2.21.1
>=20


