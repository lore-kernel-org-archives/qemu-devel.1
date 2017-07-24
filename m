Received: from eggs.gnu.org ([2001:4830:134:3::10]:55103)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dZiVK-0005jR-Fv
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 14:54:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dZiVG-0003cw-Jw
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 14:54:54 -0400
References: <20170724182751.18261-1-f4bug@amsat.org>
	<20170724182751.18261-24-f4bug@amsat.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <4de3bb09-6894-ee92-eb49-0f64efe1bad8@vivier.eu>
Date: Mon, 24 Jul 2017 20:54:34 +0200
MIME-Version: 1.0
In-Reply-To: <20170724182751.18261-24-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for 2.10 23/35] m68k/translate: fix
 incorrect copy/paste
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Eric Blake <eblake@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org

Le 24/07/2017 à 20:27, Philippe Mathieu-Daudé a écrit :
> db3d7945ae extended gen_cc_cond() for cond [6, 7, 9, 10] but misswrote [4, 5]
> 
> target/m68k/translate.c:1323:70: warning: identical expressions on both sides of logical operator
>         if (op == CC_OP_ADDB || op == CC_OP_ADDW || op == CC_OP_ADDL ||
>             op == CC_OP_ADDB || op == CC_OP_ADDW || op == CC_OP_ADDL) {
>             ~~~~~~~~~~~~~~~~    ~~~~~~~~~~~~~~~~    ~~~~~~~~~~~~~~~~ ^
> 
> Reported-by: Clang Static Analyzer
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  target/m68k/translate.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/target/m68k/translate.c b/target/m68k/translate.c
> index ada2a91b64..1a2f421aab 100644
> --- a/target/m68k/translate.c
> +++ b/target/m68k/translate.c
> @@ -1321,7 +1321,8 @@ static void gen_cc_cond(DisasCompare *c, DisasContext *s, int cond)
>      case 5: /* CS (C) */
>          /* Some cases fold C into X.  */
>          if (op == CC_OP_ADDB || op == CC_OP_ADDW || op == CC_OP_ADDL ||
> -            op == CC_OP_ADDB || op == CC_OP_ADDW || op == CC_OP_ADDL) {
> +            op == CC_OP_SUBB || op == CC_OP_SUBW || op == CC_OP_SUBL ||
> +            op == CC_OP_LOGIC) {

According to commit (db3d7945) introducing the incorrect copy/paste, I
don't think we need the CC_OP_LOGIC here. Logic operations never
generates X flags (whereas they can generate Z and and N).

Thanks,
Laurent
