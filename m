Received: from eggs.gnu.org ([2001:4830:134:3::10]:40010)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ejNoi-0001vY-7P
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 06:23:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ejNod-0000nz-AA
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 06:23:08 -0500
Received: from mail-wm0-f43.google.com ([74.125.82.43]:51105)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ejNod-0000nT-3A
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 06:23:03 -0500
Received: by mail-wm0-f43.google.com with SMTP id f71so2468941wmf.0
	for <qemu-devel@nongnu.org>; Wed, 07 Feb 2018 03:23:03 -0800 (PST)
References: <20180206203048.11096-1-rkagan@virtuozzo.com>
	<20180206203048.11096-33-rkagan@virtuozzo.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2fbc248a-9dc7-f24a-dbd3-1eb8da4295b5@redhat.com>
Date: Wed, 7 Feb 2018 12:22:58 +0100
MIME-Version: 1.0
In-Reply-To: <20180206203048.11096-33-rkagan@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 32/34] loader: allow arbitrary basename
 for fw_cfg file roms
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Roman Kagan <rkagan@virtuozzo.com>, qemu-devel@nongnu.org
Cc: Ben Warren <ben@skyportsystems.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Krish Sadhukhan <krish.sadhukhan@oracle.com>, "Marcos E. Matsunaga" <Marcos.Matsunaga@oracle.com>, Jan Dakinevich <jan.dakinevich@virtuozzo.com>, Vadim Rozenfeld <vrozenfe@redhat.com>, "Denis V. Lunev" <den@openvz.org>, si-wei liu <si-wei.liu@oracle.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, Cathy Avery <cavery@redhat.com>

On 06/02/2018 21:30, Roman Kagan wrote:
> +        basename = strrchr(fw_path, '/');
> +        if (basename && basename[1] == '\0') {
> +            /* given path terminates with '/', append basename(file) */
> +            basename = strrchr(file, '/');
> +            if (basename) {
> +                basename++;
> +            } else {
> +                basename = file;
> +            }
> +
> +            rom->fw_file = g_strdup_printf("%s%s", fw_path, basename);
>          } else {
> -            basename = rom->fw_file;
> +            rom->fw_file = g_strdup(fw_path);
>          }

Reusing basename is a bit unclear.  Maybe:

	assert(*fw_path);
	if (fw_path[strlen(fw_path) - 1] == '/') {
            /* given path terminates with '/', append basename(file) */
            const char *basename = strrchr(file, '/');
            if (basename) {
                basename++;
            } else {
                basename = file;
            }
	    rom->fw_file = g_strdup_printf("%s%s", fw_path, basename);
	} else {
            rom->fw_file = g_strdup(fw_path);
        }

Thanks,

Paolo
