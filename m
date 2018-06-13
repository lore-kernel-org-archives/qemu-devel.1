Received: from eggs.gnu.org ([2001:4830:134:3::10]:41444)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fTBr5-0007f6-Qu
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 15:54:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fTBr5-0000Gl-0E
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 15:54:55 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180611011501.10235-1-f4bug@amsat.org>
	<20180611011501.10235-5-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <896e3c84-3001-23d8-30a1-072763e86297@amsat.org>
Date: Wed, 13 Jun 2018 16:54:44 -0300
MIME-Version: 1.0
In-Reply-To: <20180611011501.10235-5-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 04/40] checkpatch: Recognize IEC binary
 prefix definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Stefan Weil <sw@weilnetz.de>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org

On 06/10/2018 10:14 PM, Philippe Mathieu-Daudé wrote:
> This fixes:
> 
>     ERROR: "foo * bar" should be "foo *bar"
>     #310: FILE: hw/ppc/ppc440_uc.c:564:
>     +        size = 8 * MiB * sh;
>     total: 1 errors, 0 warnings, 433 lines checked
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  scripts/checkpatch.pl | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index e3d8c2cdfc..4923674c71 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -322,6 +322,7 @@ sub build_types {
>  				(?:${all}\b)
>  			)
>  			(?:\s+$Modifier|\s+const)*
> +			(?:[KMGTPE]iB)
>  		  }x;
>  	$Type	= qr{
>  			$NonptrType
> 

Well this patch doesn't work like expected...

$ git diff --cached | \
  scripts/checkpatch.pl --no-signoff --debug values=2 -
 <E> <E> <_>WS(         )
 <E> <E> <_>IDENT(size)
 <E> <V> <_>WS( )
 <E> <V> <_>ASSIGN(=)
 <E> <N> <_>WS( )
 <E> <N> <_>IDENT(8)
 <E> <V> <_>WS( )
 <E> <V> <_>OPV(*)
 <E> <N> <_>WS( )
 <E> <N> <_>DECLARE(MiB * ) <------------
 <E> <T> <_>IDENT(sh)
 <E> <V> <_>END(;)
 <E> <E> <_>WS(
)
22 > .         size = 8 * MiB * sh;
22 > EEEEEEEEEEVVVVVNNVVNNTTTTTTVVEE
22 >  __________________B___________

Which looks OK, but then (example):

$ git diff --cached
diff --git a/include/net/net.h b/include/net/net.h
-void qemu_del_nic(NICState *nic);
+void qemu_del_nic(NICState *test);

$ git diff --cached | \
  scripts/checkpatch.pl --no-signoff --debug values=2 -

 void qemu_del_nic(NICState *test);

 <E> <E> <_>WS( )
 <E> <E> <_>IDENT(void)
 <E> <V> <_>WS( )
 <E> <V> <_>FUNC(qemu_del_nic)
 <E> <V> <V>PAREN('(')
 <EV> <N> <_>IDENT(NICState)
 <EV> <V> <_>WS( )
 <EV> <V> <_>OPV(*)
 <EV> <N> <_>IDENT(test)
 <EV> <V> <_>PAREN(')') -> V
 <E> <V> <_>END(;)
 <E> <E> <_>WS(
)
10 > . void qemu_del_nic(NICState *test);
10 > EEVVVVVVVVVVVVVVVVVNVVVVVVVVVNVVVVVEE
10 >  ____________________________B_______
ERROR: spaces required around that '*' (ctx:WxV)
#10: FILE: include/net/net.h:136:
+void qemu_del_nic(NICState *test);
                            ^
