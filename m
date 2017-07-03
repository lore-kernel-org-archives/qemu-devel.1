Received: from eggs.gnu.org ([2001:4830:134:3::10]:47310)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dS7IW-0000NO-Qm
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 15:46:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dS7IR-0003rv-W5
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 15:46:16 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:34068)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dS7IR-0003rR-RD
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 15:46:11 -0400
Received: by mail-qt0-x244.google.com with SMTP id m54so22154822qtb.1
	for <qemu-devel@nongnu.org>; Mon, 03 Jul 2017 12:46:11 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1499099693-22903-1-git-send-email-pbonzini@redhat.com>
	<1499099693-22903-5-git-send-email-pbonzini@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <1cfd6e25-727e-2b11-b662-4a2b7dbaed05@twiddle.net>
Date: Mon, 3 Jul 2017 12:46:06 -0700
MIME-Version: 1.0
In-Reply-To: <1499099693-22903-5-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 04/22] vl: convert -tb-size to qemu_strtoul
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: thuth@redhat.com, anthony.xu@intel.com, berrange@redhat.com, a.rigo@virtualopensystems.com, yang.zhong@intel.com

On 07/03/2017 09:34 AM, Paolo Bonzini wrote:
> -extern int tcg_tb_size;
> +extern unsigned long tcg_tb_size;

size_t would be more natural.

I don't think we support any hosts for which sizeof(size_t) != sizeof(unsigned 
long), but perhaps

	unsigned lomg tmp;
	if (qemu_strtoul(optarg, NULL, 0, &tmp) < 0
             || tmp != (size_t)tmp) {
	  error_report("Invalid argument to -tb-size");
	  exit(1);
	}
	tcg_tb_size = tmp;

where I'd expect the extra comparison to be optimized away.

But I'm not overly concerned either way, so

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
