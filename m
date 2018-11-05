Received: from eggs.gnu.org ([2001:4830:134:3::10]:43772)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gJaE4-0006Q9-6T
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 03:27:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gJaDZ-0001kU-KS
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 03:27:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46580)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gJaDY-0000Go-N3
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 03:26:40 -0500
Date: Mon, 5 Nov 2018 09:26:22 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20181105082622.yzxz3dis77knkpoa@sirius.home.kraxel.org>
References: <1541052594-29132-1-git-send-email-liq3ea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1541052594-29132-1-git-send-email-liq3ea@gmail.com>
Subject: Re: [Qemu-devel] [PATCH 1/2] hw: fw_cfg: ensure reboot_time is
 nonegative
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@gmail.com>
Cc: pbonzini@redhat.com, armbru@redhat.com, philmd@redhat.com, lersek@redhat.com, qemu-devel@nongnu.org

> -    /* validate the input */
> -    if (reboot_timeout > 0xffff) {
> -        error_report("reboot timeout is larger than 65535, force it to 65535.");
> -        reboot_timeout = 0xffff;
> +
> +    if (reboot_timeout >= 0) {
> +        /* validate the input */
> +        if (reboot_timeout > 0xffff) {
> +            error_report("reboot timeout is larger than 65535,"
> +                         "force it to 65535.");
> +            reboot_timeout = 0xffff;
> +        }
> +        fw_cfg_add_file(s, "etc/boot-fail-wait",
> +                        g_memdup(&reboot_timeout, 4), 4);
>      }

Hmm, values > 0xffff are reported and values < 0 are silently ignored.
I think we should be consistent here.
I'd suggest report and exit in both cases,
i.e. use error_setg(..., &error_fatal);

cheers,
  Gerd
