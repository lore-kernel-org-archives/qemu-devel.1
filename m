Received: from eggs.gnu.org ([2001:4830:134:3::10]:42656)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gZ4Ta-0004T0-Qq
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 20:47:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gZ4TV-0008PT-Sr
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 20:47:14 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:54785)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gZ4TV-0008PG-KO
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 20:47:09 -0500
Date: Mon, 17 Dec 2018 20:47:07 -0500
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20181218014707.GA10098@flamenco>
References: <20181217105650.27361-1-alex.bennee@linaro.org>
	<20181217105650.27361-9-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181217105650.27361-9-alex.bennee@linaro.org>
Subject: Re: [Qemu-devel] [PULL v3 08/15] tests/fp: add fp-bench
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>

On Mon, Dec 17, 2018 at 10:56:43 +0000, Alex Bennée wrote:
> From: "Emilio G. Cota" <cota@braap.org>
> +static void update_random_ops(int n_ops, enum precision prec)
> +{
> +    int i;
> +
> +    for (i = 0; i < n_ops; i++) {
> +        uint64_t r = random_ops[i];
> +
> +        if (prec == PREC_SINGLE || PREC_FLOAT32) {
> +            do {
> +                r = xorshift64star(r);
> +            } while (!float32_is_normal(r));
> +        } else if (prec == PREC_DOUBLE || PREC_FLOAT64) {

I just noticed that there's a bug here (I was seeing non-normals
where I didn't expect any):

     for (i = 0; i < n_ops; i++) {
         uint64_t r = random_ops[i];
 
-        if (prec == PREC_SINGLE || PREC_FLOAT32) {
+        if (prec == PREC_SINGLE || prec == PREC_FLOAT32) {
             do {
                 r = xorshift64star(r);
             } while (!float32_is_normal(r));
-        } else if (prec == PREC_DOUBLE || PREC_FLOAT64) {
+        } else if (prec == PREC_DOUBLE || prec == PREC_FLOAT64) {
             do {
                 r = xorshift64star(r);
             } while (!float64_is_normal(r));

Let me know if you want me to send a proper patch (this is non-critical
so it's OK to fix after merging) or you'd rather fix it up directly.

Thanks,

		E.
