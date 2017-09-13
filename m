Received: from eggs.gnu.org ([2001:4830:134:3::10]:33217)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1dsEtq-0000n3-KN
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 17:08:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1dsEtl-0001A3-IF
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 17:08:46 -0400
Received: from iserv.reactos.org ([2a01:4f8:221:4c5::3]:53240)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <hpoussin@reactos.org>)
	id 1dsEtl-00016t-4s
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 17:08:41 -0400
References: <1505293637-10450-1-git-send-email-thuth@redhat.com>
From: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>
Message-ID: <67cd5928-8afa-ede8-039b-a0204e504df7@reactos.org>
Date: Wed, 13 Sep 2017 23:08:35 +0200
MIME-Version: 1.0
In-Reply-To: <1505293637-10450-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] hw/isa/pc87312: Mark the device with
 user_creatable = false
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, qemu-trivial@nongnu.org

Le 13/09/2017 à 11:07, Thomas Huth a écrit :
> QEMU currently aborts if you try to use the device at the command
> line:
> 
> $ ppc64-softmmu/qemu-system-ppc64 -S -machine prep -device pc87312
> Unexpected error in qemu_chr_fe_init() at chardev/char-fe.c:222:
> qemu-system-ppc64: -device pc87312: Device 'parallel0' is in use
> Aborted (core dumped)
> 
> It uses parallel_hds in its realize function, so I can not be
> instantiated by the user again.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Hervé Poussineau <hpoussin@reactos.org>

However, a better solution would probably to not directly use parallel_hds[0], but to add some Chardev properties to the device, and to fill them in the mainboard code.
This is noted as a "Future incompatible change" in changelog since 2.8

Hervé

> ---
>   hw/isa/pc87312.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/hw/isa/pc87312.c b/hw/isa/pc87312.c
> index 5ce9f0a..48b29e3 100644
> --- a/hw/isa/pc87312.c
> +++ b/hw/isa/pc87312.c
> @@ -386,6 +386,8 @@ static void pc87312_class_init(ObjectClass *klass, void *data)
>       dc->reset = pc87312_reset;
>       dc->vmsd = &vmstate_pc87312;
>       dc->props = pc87312_properties;
> +    /* Reason: Uses parallel_hds[0] in realize(), so it can't be used twice */
> +    dc->user_creatable = false;
>   }
>   
>   static const TypeInfo pc87312_type_info = {
> 
