Received: from eggs.gnu.org ([209.51.188.92]:33368)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1glu7I-0004GS-GF
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 06:21:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1glu7G-0004PE-Go
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 06:21:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36898)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rjones@redhat.com>) id 1glu7G-0004N1-99
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 06:21:14 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 04202A1F64
	for <qemu-devel@nongnu.org>; Tue, 22 Jan 2019 11:21:11 +0000 (UTC)
Date: Tue, 22 Jan 2019 11:21:09 +0000
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20190122112109.GB18917@redhat.com>
References: <20190102140535.11512-1-cfergeau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190102140535.11512-1-cfergeau@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] json: Fix % handling when not interpolating
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christophe Fergeau <cfergeau@redhat.com>
Cc: qemu-devel@nongnu.org

On Wed, Jan 02, 2019 at 03:05:35PM +0100, Christophe Fergeau wrote:
> commit 8bca4613 added support for %% in json strings when interpolating,
> but in doing so, this broke handling of % when not interpolating as the
> '%' is skipped in both cases.
> This commit ensures we only try to handle %% when interpolating.
> 
> Signed-off-by: Christophe Fergeau <cfergeau@redhat.com>
> ---
>  qobject/json-parser.c | 10 ++++++----
>  tests/check-qjson.c   |  5 +++++
>  2 files changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/qobject/json-parser.c b/qobject/json-parser.c
> index 7a7ae9e8d1..d8eb210c0c 100644
> --- a/qobject/json-parser.c
> +++ b/qobject/json-parser.c
> @@ -208,11 +208,13 @@ static QString *parse_string(JSONParserContext *ctxt, JSONToken *token)
>              }
>              break;
>          case '%':
> -            if (ctxt->ap && ptr[1] != '%') {
> -                parse_error(ctxt, token, "can't interpolate into string");
> -                goto out;
> +            if (ctxt->ap) {
> +                if (ptr[1] != '%') {
> +                    parse_error(ctxt, token, "can't interpolate into string");
> +                    goto out;
> +                }
> +                ptr++;
>              }
> -            ptr++;
>              /* fall through */
>          default:
>              cp = mod_utf8_codepoint(ptr, 6, &end);
> diff --git a/tests/check-qjson.c b/tests/check-qjson.c
> index d876a7a96e..fa2afccb0a 100644
> --- a/tests/check-qjson.c
> +++ b/tests/check-qjson.c
> @@ -175,6 +175,11 @@ static void utf8_string(void)
>              "\xCE\xBA\xE1\xBD\xB9\xCF\x83\xCE\xBC\xCE\xB5",
>              "\xCE\xBA\xE1\xBD\xB9\xCF\x83\xCE\xBC\xCE\xB5",
>              "\\u03BA\\u1F79\\u03C3\\u03BC\\u03B5",
> +        },
> +            /* '%' character when not interpolating */
> +        {
> +            "100%",
> +            "100%",
>          },
>          /* 2  Boundary condition test cases */
>          /* 2.1  First possible sequence of a certain length */

Tested-by: Richard W.M. Jones <rjones@redhat.com>

as a fix for: https://bugzilla.redhat.com/show_bug.cgi?id=1668244#c3

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-top is 'top' for virtual machines.  Tiny program with many
powerful monitoring features, net stats, disk stats, logging, etc.
http://people.redhat.com/~rjones/virt-top
