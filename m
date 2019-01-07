Received: from eggs.gnu.org ([209.51.188.92]:49789)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1ggZ5E-0004dZ-3c
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 12:53:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1ggZ4F-0000Em-Rv
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 12:52:05 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39020)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ggZ4F-0000Cv-LO
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 12:52:03 -0500
Received: by mail-wm1-f65.google.com with SMTP id f81so1769908wmd.4
	for <qemu-devel@nongnu.org>; Mon, 07 Jan 2019 09:52:02 -0800 (PST)
References: <20181221195200.6544-1-cota@braap.org>
	<20181221195200.6544-2-cota@braap.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <0f16e9a4-9a5c-d1b0-16d3-daa480fc1491@redhat.com>
Date: Mon, 7 Jan 2019 18:51:59 +0100
MIME-Version: 1.0
In-Reply-To: <20181221195200.6544-2-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/2] fp-bench: fix update_random_ops
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 12/21/18 8:51 PM, Emilio G. Cota wrote:
> The second test in the branches is wrong; fix while converting
> to a switch statement, which is easier to get right.
> 
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  tests/fp/fp-bench.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/tests/fp/fp-bench.c b/tests/fp/fp-bench.c
> index f5bc5edebf..546bac9c9c 100644
> --- a/tests/fp/fp-bench.c
> +++ b/tests/fp/fp-bench.c
> @@ -143,15 +143,20 @@ static void update_random_ops(int n_ops, enum precision prec)
>      for (i = 0; i < n_ops; i++) {
>          uint64_t r = random_ops[i];
>  
> -        if (prec == PREC_SINGLE || PREC_FLOAT32) {

:)

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> +        switch (prec) {
> +        case PREC_SINGLE:
> +        case PREC_FLOAT32:
>              do {
>                  r = xorshift64star(r);
>              } while (!float32_is_normal(r));
> -        } else if (prec == PREC_DOUBLE || PREC_FLOAT64) {
> +            break;
> +        case PREC_DOUBLE:
> +        case PREC_FLOAT64:
>              do {
>                  r = xorshift64star(r);
>              } while (!float64_is_normal(r));
> -        } else {
> +            break;
> +        default:
>              g_assert_not_reached();
>          }
>          random_ops[i] = r;
> 
