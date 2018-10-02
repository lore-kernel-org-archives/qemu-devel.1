Received: from eggs.gnu.org ([2001:4830:134:3::10]:40277)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1g7Nrs-0002on-KT
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 12:49:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1g7Nrr-0006Nz-PK
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 12:49:52 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:43102)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1g7Nrr-0006No-Gg
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 12:49:51 -0400
Received: by mail-wr1-x442.google.com with SMTP id n1-v6so3014064wrt.10
	for <qemu-devel@nongnu.org>; Tue, 02 Oct 2018 09:49:51 -0700 (PDT)
MIME-Version: 1.0
References: <20181002162652.19377-1-liq3ea@163.com>
In-Reply-To: <20181002162652.19377-1-liq3ea@163.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 2 Oct 2018 20:49:38 +0400
Message-ID: <CAJ+F1CJmCMzkDN3fyaZ6GLyHxvoYv_GiELNAAiQTsr0WEVOchQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] tests: check-qjson: fix a memory leak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: liq3ea@163.com
Cc: Markus Armbruster <armbru@redhat.com>, QEMU <qemu-devel@nongnu.org>

Hi
On Tue, Oct 2, 2018 at 8:27 PM Li Qiang <liq3ea@163.com> wrote:
>
> Spotted by ASAN.
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =3D=3D17531=3D=3DERROR: LeakSanitizer: detected memory leaks
>
> Direct leak of 1120 byte(s) in 28 object(s) allocated from:
>     #0 0x7f9fb85eeb50 in __interceptor_malloc (/usr/lib/x86_64-linux-gnu/=
libasan.so.4+0xdeb50)
>     #1 0x7f9fb824b8d8 in g_malloc (/usr/lib/x86_64-linux-gnu/libglib-2.0.=
so.0+0x518d8)
>     #2 0x5654ae94f073 in qstring_from_str qobject/qstring.c:66
>     #3 0x5654ae94ede7 in qstring_new qobject/qstring.c:23
>     #4 0x5654ae953b6b in parse_string qobject/json-parser.c:143
>     #5 0x5654ae955e3e in parse_literal qobject/json-parser.c:484
>     #6 0x5654ae956227 in parse_value qobject/json-parser.c:547
>     #7 0x5654ae9565c7 in json_parser_parse qobject/json-parser.c:573
>     #8 0x5654ae952d5d in json_message_process_token qobject/json-streamer=
.c:92
>     #9 0x5654ae9608fa in json_lexer_feed_char qobject/json-lexer.c:313
>     #10 0x5654ae960ea5 in json_lexer_feed qobject/json-lexer.c:350
>     #11 0x5654ae9530de in json_message_parser_feed qobject/json-streamer.=
c:121
>     #12 0x5654ae950b6e in qobject_from_jsonv qobject/qjson.c:69
>     #13 0x5654ae950d30 in qobject_from_json qobject/qjson.c:83
>     #14 0x5654ae9449af in from_json_str tests/check-qjson.c:30
>     #15 0x5654ae946399 in utf8_string tests/check-qjson.c:781
>     #16 0x7f9fb826cc39  (/usr/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x72c=
39)
>
> Signed-off-by: Li Qiang <liq3ea@163.com>

already sent and queued by Markus:
https://patchew.org/QEMU/20180901211917.10372-1-marcandre.lureau@redhat.com=
/

> ---
>  tests/check-qjson.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tests/check-qjson.c b/tests/check-qjson.c
> index cc13f3d41e..d876a7a96e 100644
> --- a/tests/check-qjson.c
> +++ b/tests/check-qjson.c
> @@ -780,6 +780,7 @@ static void utf8_string(void)
>              if (!strstr(json_out, "\\uFFFD")) {
>                  str =3D from_json_str(json_out, j, &error_abort);
>                  g_assert_cmpstr(qstring_get_try_str(str), =3D=3D, utf8_i=
n);
> +                qobject_unref(str);
>              }
>          }
>      }
> --
> 2.17.1
>
>
>


--=20
Marc-Andr=C3=A9 Lureau
