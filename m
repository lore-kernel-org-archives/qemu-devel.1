Received: from eggs.gnu.org ([2001:4830:134:3::10]:49566)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1euObt-0007BT-18
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 15:27:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1euObp-00066x-Td
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 15:27:25 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:49789)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1euObp-00066f-KP
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 15:27:21 -0500
References: <20171228180814.9749-1-lukeshu@lukeshu.com>
	<20171228180814.9749-5-lukeshu@lukeshu.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <bcc1b0b4-8c70-be90-1e6a-71c34a2c6cd9@vivier.eu>
Date: Fri, 9 Mar 2018 21:26:56 +0100
MIME-Version: 1.0
In-Reply-To: <20171228180814.9749-5-lukeshu@lukeshu.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 04/10] linux-user: init_guest_space:
 Correctly handle guest_start in commpage initialization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Luke Shumaker <lukeshu@lukeshu.com>, qemu-devel@nongnu.org
Cc: Luke Shumaker <lukeshu@parabola.nu>, Riku Voipio <riku.voipio@iki.fi>

Le 28/12/2017 à 19:08, Luke Shumaker a écrit :
> From: Luke Shumaker <lukeshu@parabola.nu>
> 
> init_guest_commpage  needs to check if the mapped space, which ends at
> real_start+real_size overlaps with where it needs to put the commpage,
> which is (assuming sane qemu_host_page_size) guest_base + 0xffff000, where
> guest_base is real_start - guest_start.
> 
>     [guest_base][       0xffff0000      ][commpage]
>     [guest_base][guest_start][real_size] [commpage]
>     [       real_start      ][real_size] [commpage]
>                                         ^
>                                  fail if this gap < 0
> 
> Since init_guest_commpage wants to do everything relative to guest_base
> (rather than real_start), it obviously needs to be comparing 0xffff0000
> against guest_start+real_size, not just real_size.
> 
> This bug has been present since 806d102141b99d4f1e55a97d68b7ea8c8ba3129f in
> 2012, but guest_start is usually 0, and prior to v2.11 real_size was
> usually much smaller than 0xffff0000, so it was uncommon for it to have
> made a difference.
> 
> Signed-off-by: Luke Shumaker <lukeshu@parabola.nu>
> ---
>  linux-user/elfload.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to my 'linux-user-for-2.12' branch.

Thanks,
Laurent
