Received: from eggs.gnu.org ([2001:4830:134:3::10]:57086)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1g05zm-00063O-L5
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 10:19:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1g05zi-0007uj-KQ
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 10:19:54 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:45048)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1g05zi-0007rP-Ag
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 10:19:50 -0400
Received: by mail-pf1-x443.google.com with SMTP id k21-v6so1080532pff.11
	for <qemu-devel@nongnu.org>; Wed, 12 Sep 2018 07:19:50 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1536743677-17885-1-git-send-email-lizhijian@cn.fujitsu.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <bbc05631-8959-5736-e8bb-d0445e16f9bb@twiddle.net>
Date: Wed, 12 Sep 2018 07:19:46 -0700
MIME-Version: 1.0
In-Reply-To: <1536743677-17885-1-git-send-email-lizhijian@cn.fujitsu.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] change get_image_size return type to
 int64_t
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Zhijian <lizhijian@cn.fujitsu.com>, mst@redhat.com, marcel.apfelbaum@gmail.com, pbonzini@redhat.com, ehabkost@redhat.com, amarkovic@wavecomp.com, aurelien@aurel32.net, green@moxielogic.com, qemu-devel@nongnu.org
Cc: philip.li@intel.com

On 09/12/2018 02:14 AM, Li Zhijian wrote:
> @@ -838,7 +838,8 @@ static void load_linux(PCMachineState *pcms,
>                         FWCfgState *fw_cfg)
>  {
>      uint16_t protocol;
> -    int setup_size, kernel_size, initrd_size = 0, cmdline_size;
> +    int setup_size, kernel_size, cmdline_size;
> +    int64_t initrd_size = 0;
>      int dtb_size, setup_data_offset;
>      uint32_t initrd_max;
>      uint8_t header[8192], *setup, *kernel, *initrd_data;
> @@ -974,6 +975,10 @@ static void load_linux(PCMachineState *pcms,
>              fprintf(stderr, "qemu: error reading initrd %s: %s\n",
>                      initrd_filename, strerror(errno));
>              exit(1);
> +        } else if (initrd_size >= UINT32_MAX) {
> +            fprintf(stderr, "qemu: failed to load initrd beyond 4G(%ld)\n",
> +                    initrd_size);

You need to use PRId64 instead of %ld here.
Otherwise this will fail 32-bit host builds.

You could try this yourself with e.g.

  make docker-test-build@debian-win32-cross


r~
