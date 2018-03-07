Received: from eggs.gnu.org ([2001:4830:134:3::10]:41648)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1etXQp-0003WV-7o
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 06:40:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1etXQl-0006Yl-Qf
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 06:40:26 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45848 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1etXQl-0006Xv-MC
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 06:40:23 -0500
References: <cover.1515960078.git.pisa@cmp.felk.cvut.cz>
	<48c4af3c240286a89fc5fdbcaa254ea386c979b9.1515960078.git.pisa@cmp.felk.cvut.cz>
	<a7069bf9-4321-5fa7-69ac-15d88737c5ec@redhat.com>
	<201803062152.08551.pisa@cmp.felk.cvut.cz>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1f198965-269b-90ce-d32e-9e0217dd19e8@redhat.com>
Date: Wed, 7 Mar 2018 12:40:13 +0100
MIME-Version: 1.0
In-Reply-To: <201803062152.08551.pisa@cmp.felk.cvut.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH V4 4/7] CAN bus Kvaser PCI CAN-S (single
 SJA1000 channel) emulation added.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Pisa <pisa@cmp.felk.cvut.cz>, Thomas Huth <thuth@redhat.com>, Deniz Eren <deniz.eren@icloud.com>
Cc: qemu-devel@nongnu.org, Marek Vasut <marex@denx.de>, Oliver Hartkopp <socketcan@hartkopp.net>, Stefan Hajnoczi <stefanha@gmail.com>, Oleksij Rempel <o.rempel@pengutronix.de>, Konrad Frederic <frederic.konrad@adacore.com>, Jan Kiszka <jan.kiszka@siemens.com>

On 06/03/2018 21:52, Pavel Pisa wrote:
> Hello Thomas,
> 
> thanks for report but I at this time I am and
> can be some time in condition which does not allow
> me to access e-mail and normal work
> 
> On Tuesday 06 of March 2018 16:29:19 Thomas Huth wrote:
>> On 14.01.2018 21:14, pisa@cmp.felk.cvut.cz wrote:
>>> From: Pavel Pisa <pisa@cmp.felk.cvut.cz>
>>>
>>> Signed-off-by: Pavel Pisa <pisa@cmp.felk.cvut.cz>
>>> ---
>>>  default-configs/pci.mak |   1 +
>>>  hw/can/Makefile.objs    |   1 +
>>>  hw/can/can_kvaser_pci.c | 375
>>> ++++++++++++++++++++++++++++++++++++++++++++++++ 3 files changed, 377
>>> insertions(+)
>>>  create mode 100644 hw/can/can_kvaser_pci.c
>>
>>  Hi,
>>
>> the kvaser_pci device introduced a new way to crash QEMU, e.g.:
>>
>> mips64el-softmmu/qemu-system-mips64el -M malta,accel=qtest \
>>                                       -device kvaser_pci
>>
>> Program received signal SIGSEGV, Segmentation fault.
>> 0x0000555555a6e2ec in can_bus_insert_client (bus=0x0,
>> client=client@entry=0x5555570c4018) at
>> /home/thuth/devel/qemu/net/can/can_core.c:50
>> 50	    QTAILQ_INSERT_TAIL(&bus->clients, client, next);
> 
> The reason is that parameters canbus0 and canbus1 are required.
> 
>   -object can-bus,id=canbus0 \
>   -device kvaser_pci,canbus0=canbus0
> 
> This could be be fast fix but plead somebody else to send regular
> patch.
> 
> --- a/net/can/can_host.c
> +++ b/net/can/can_host.c
> @@ -57,6 +57,10 @@ static void can_host_connect(CanHostState *ch, Error **errp)
>          return;
>      }
> 
> +    if (ch->bus_client == NULL) {
> +        error_setg(errp, "bus is not specified for given device.");
> +        return;
> +    }
>      can_bus_insert_client(ch->bus, &ch->bus_client);
>  }

Ok, I'll check it out.

Thanks Thomas for the report!

Paolo
