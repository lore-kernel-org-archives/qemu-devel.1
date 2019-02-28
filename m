Received: from eggs.gnu.org ([209.51.188.92]:45406)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gzQAB-0006R1-Su
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 13:12:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gzQA9-0007z8-Tc
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 13:12:07 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38071)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gzQA6-0007vk-VD
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 13:12:04 -0500
Received: by mail-wr1-f66.google.com with SMTP id g12so10967288wrm.5
	for <qemu-devel@nongnu.org>; Thu, 28 Feb 2019 10:11:53 -0800 (PST)
References: <63559cf027d4ebd95a844b73b1f20444fb72fb2c.camel@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <62cddadf-8327-fdd1-baa9-c4ade791b8ee@redhat.com>
Date: Thu, 28 Feb 2019 19:11:51 +0100
MIME-Version: 1.0
In-Reply-To: <63559cf027d4ebd95a844b73b1f20444fb72fb2c.camel@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3] trivial fix of malloc to g_new in thunk
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aarushi Mehta <mehta.aaru20@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>, Stefan Hajnoczi <stefanha@gmail.com>, Julia Suvorova <jusual@mail.ru>

On 2/28/19 5:46 PM, Aarushi Mehta wrote:
> Signed-off-by: Aarushi Mehta <mehta.aaru20@gmail.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> 
> Note that since thunking occurs throughout the lifetime of the QEMU
> instance, there is no matching 'free' to correct.
> 
> ---
>  thunk.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/thunk.c b/thunk.c
> index d5d8645cd4..17f3d320bb 100644
> --- a/thunk.c
> +++ b/thunk.c
> @@ -89,7 +89,7 @@ void thunk_register_struct(int id, const char *name,
> const argtype *types)

Clearer than using a single:

       se->field_offsets = g_new(int *, nb_fields * 2);

So:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

>      for(i = 0;i < 2; i++) {

BTW we can replace here by:

       for (i = 0; i < ARRAY_SIZE(se->field_offsets); i++) {

>          offset = 0;
>          max_align = 1;
> -        se->field_offsets[i] = malloc(nb_fields * sizeof(int));
> +        se->field_offsets[i] = g_new(int, nb_fields);
>          type_ptr = se->field_types;
>          for(j = 0;j < nb_fields; j++) {
>              size = thunk_type_size(type_ptr, i);
> 
