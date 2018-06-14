Received: from eggs.gnu.org ([2001:4830:134:3::10]:59878)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fTWqK-0005iV-Cv
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 14:19:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fTWqH-0008EH-8B
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 14:19:32 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:38818)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fTWqH-0008Dx-0A
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 14:19:29 -0400
Received: by mail-wr0-x241.google.com with SMTP id e18-v6so7429653wrs.5
	for <qemu-devel@nongnu.org>; Thu, 14 Jun 2018 11:19:28 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20180614180119.1704-1-f4bug@amsat.org>
	<20180614180119.1704-2-f4bug@amsat.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <bafda81a-a33b-6137-b30a-1cf98ab8393b@redhat.com>
Date: Thu, 14 Jun 2018 20:19:25 +0200
MIME-Version: 1.0
In-Reply-To: <20180614180119.1704-2-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH 1/2] hw/isa/smc37c669-superio: Basic
 'Config Registers' implementation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, "Emilio G . Cota" <cota@braap.org>, Richard Henderson <rth@twiddle.net>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>
Cc: qemu-devel@nongnu.org

On 14/06/2018 20:01, Philippe Mathieu-Daudé wrote:
> +
> +static Property smc37c669_properties[] = {
> +    DEFINE_PROP_UINT32("config", SMC37C669State, config, 0x78889c28),
> +    DEFINE_PROP_BIT("parallel", SMC37C669State, config, 8 + 2, true),
> +    DEFINE_PROP_END_OF_LIST()
> +};

I would initialize the config word in instance_init rather
than using a property.  Having overlapping properties for the same field
sounds like a recipe for undesired behavior.

But why isn't the parallel port at 0x378?  That's the expected place on
PC (the second parallel port is at 0x278 and the third is at 0x3bc), and
I would expect other SuperIO chips to have it there too.  That would be
a one line fix.

Yet another possibility is to disable EPP on the parallel port, so that
it occupies only the addresses from 0x3bc to 0x3be.

Paolo
