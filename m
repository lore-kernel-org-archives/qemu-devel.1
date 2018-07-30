Received: from eggs.gnu.org ([2001:4830:134:3::10]:49111)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fkCQK-0000R0-8b
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 13:57:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fkCQJ-0004VE-Cc
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 13:57:36 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:39435)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fkCQJ-0004Up-0Z
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 13:57:35 -0400
Received: by mail-oi0-x242.google.com with SMTP id d189-v6so22877766oib.6
	for <qemu-devel@nongnu.org>; Mon, 30 Jul 2018 10:57:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180725085944.11856-6-stefanha@redhat.com>
References: <20180725085944.11856-1-stefanha@redhat.com>
	<20180725085944.11856-6-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 30 Jul 2018 18:57:13 +0100
Message-ID: <CAFEAcA8N26yjrLeaDzkoJfx50Rd5h_y9hHVA8W19L9q1EOhfMA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 5/7] loader: add rom transaction API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Steffen_G=C3=B6rtz?= <mail@steffen-goertz.de>, Alistair Francis <alistair@alistair23.me>, Liviu Ionescu <ilg@livius.net>, qemu-arm <qemu-arm@nongnu.org>, Julia Suvorova <jusual@mail.ru>, Subbaraya Sundeep <sundeep.lkml@gmail.com>, Su Hang <suhang16@mails.ucas.ac.cn>, Steffen Gortz <qemu.ml@steffen-goertz.de>, Jim Mussared <jim@groklearning.com>, Joel Stanley <joel@jms.id.au>

On 25 July 2018 at 09:59, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> Image file loaders may add a series of roms.  If an error occurs partway
> through loading there is no easy way to drop previously added roms.
>
> This patch adds a transaction mechanism that works like this:
>
>   rom_transaction_begin();
>   ...call rom_add_*()...
>   rom_transaction_end(ok);
>
> If ok is false then roms added in this transaction are dropped.
>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
> +void rom_transaction_end(bool commit)
> +{
> +    Rom *rom;
> +    Rom *tmp;
> +
> +    QTAILQ_FOREACH_SAFE(rom, &roms, next, tmp) {
> +        if (rom->committed) {
> +            continue;
> +        }
> +        if (commit) {
> +            rom->committed = true;
> +        } else {
> +            QTAILQ_REMOVE(&roms, rom, next);
> +            g_free(rom->data);
> +            g_free(rom->path);
> +            g_free(rom->name);
> +            g_free(rom->fw_dir);
> +            g_free(rom->fw_file);
> +            g_free(rom);

Is it worth having a rom_free() function so we can
share the "free all the pointers" code between this
and the error-exit codepath at the end of rom_add_file() ?

Either way
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
