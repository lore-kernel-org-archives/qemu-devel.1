Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11A31C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 20:06:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0661206E9
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 20:06:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AIF71ai0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0661206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36386 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCqZR-0005eI-1c
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 16:06:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41780)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jCqYO-0004jD-9o
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 16:05:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jCqYM-0001uJ-OJ
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 16:05:08 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47795
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jCqYM-0001oV-K2
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 16:05:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584129905;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4WKl3OxXUu1RUziz705+F7Hlt0QT5ASQZZHIG0nAsRs=;
 b=AIF71ai0lfVezcGATSx/R8ZSNztnLVnnRS5bLb538dMb50Ue31/hNBBvNnWFKnJ50uKvbS
 LjN0NH/phmtHN/Bhs7TnzH8mgxVLLv4DoQhkkFFxXyiOHKvywDEIXvoCiavRZ+bocKyIC7
 CYwncY2b3NUSFjF4kgJsP665aUcr72w=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-236-lQ5LqBGxMNGKQPhCtnshEA-1; Fri, 13 Mar 2020 16:05:03 -0400
X-MC-Unique: lQ5LqBGxMNGKQPhCtnshEA-1
Received: by mail-wr1-f72.google.com with SMTP id w11so4809947wrp.20
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2020 13:05:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=MHUu65OsUs5rTIQn3UrH+sN/j4dlRccZUOvQEJqrsRQ=;
 b=mAdpCBYMdSW77DsQxrS25Xvl+GVdlcrQGlEQxIGIJsqvhurLPLpUPX3okwN2gxeouD
 HGdctcedSiJ+q0/iZ9eCmIxFytHO7qirzQra77lHCFnOirfWxLoWTnPve8RXQyh3ijeX
 NJaMMNgDtziwevm5fGAOMFO1TPaFe6GYWK8pv5FI0Rdwq6mwXejdpeqBJP8vMABUgVNR
 FCVskFQox1nFZMImcMbkt0V7+qgbWTN4l+3akeRNVjSLqQnrLqVqywCm9YTebdmQbepQ
 h42nFoA7D5VeLTItvDum9SGaB7Q22Z+32+Ht/ehEdbNNYibw3W+B2pDWsxG5u5ueFVya
 mX6A==
X-Gm-Message-State: ANhLgQ0+V/AnGb+ag3oY2mAXxFfbm2nnFiUJkvgpql4llLjCNenixgYz
 cpZCvEMe7QUnQd3nrBWNSjCLwSLO4I9lUr3bD1c8eZnXXvp1IGg7PheFDnn8KHXumHlp6+zLTyk
 +amB/Nbqil0jjXf8=
X-Received: by 2002:adf:e64f:: with SMTP id b15mr15991024wrn.424.1584129902176; 
 Fri, 13 Mar 2020 13:05:02 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vv3hshrMMPiHRJIGJ5w28qoli5ucb/OfEJMjYzLR6vNhXIrFXGijPbPo1pve9Nu75m/rftMMw==
X-Received: by 2002:adf:e64f:: with SMTP id b15mr15990999wrn.424.1584129901947; 
 Fri, 13 Mar 2020 13:05:01 -0700 (PDT)
Received: from [192.168.1.35] (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id y15sm26164193wrq.89.2020.03.13.13.05.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Mar 2020 13:05:01 -0700 (PDT)
Subject: Re: [PATCH v3 08/16] hw/i386/vmport: Define enum for all commands
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
To: Liran Alon <liran.alon@oracle.com>, qemu-devel@nongnu.org
References: <20200312165431.82118-1-liran.alon@oracle.com>
 <20200312165431.82118-9-liran.alon@oracle.com>
 <3dbe8a7f-73e3-691b-2e14-c287cafd9e7c@redhat.com>
Message-ID: <d504b96e-5cfa-ce23-5e66-c2f48853b432@redhat.com>
Date: Fri, 13 Mar 2020 21:05:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <3dbe8a7f-73e3-691b-2e14-c287cafd9e7c@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: pbonzini@redhat.com, Nikita Leshenko <nikita.leshchenko@oracle.com>,
 rth@twiddle.net, ehabkost@redhat.com, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/13/20 8:59 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> On 3/12/20 5:54 PM, Liran Alon wrote:
>> No functional change.
>>
>> Defining an enum for all VMPort commands have the following advantages:
>> * It gets rid of the error-prone requirement to update VMPORT_ENTRIES
>> when new VMPort commands are added to QEMU.
>> * It makes it clear to know by looking at one place at the source, what
>> are all the VMPort commands supported by QEMU.
>>
>> Reviewed-by: Nikita Leshenko <nikita.leshchenko@oracle.com>
>> Signed-off-by: Liran Alon <liran.alon@oracle.com>
>> ---
>> =C2=A0 hw/i386/vmmouse.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 18 =
++++++------------
>> =C2=A0 hw/i386/vmport.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
| 11 ++---------
>> =C2=A0 include/hw/i386/vmport.h | 11 ++++++++++-
>=20
> Please setup scripts/git.orderfile to ease reviews.
>=20
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>=20
>> =C2=A0 3 files changed, 18 insertions(+), 22 deletions(-)
>>
>> diff --git a/hw/i386/vmmouse.c b/hw/i386/vmmouse.c
>> index 49a546fd3bb6..afb8e9e09a30 100644
>> --- a/hw/i386/vmmouse.c
>> +++ b/hw/i386/vmmouse.c
>> @@ -34,12 +34,6 @@
>> =C2=A0 /* debug only vmmouse */
>> =C2=A0 //#define DEBUG_VMMOUSE
>> -/* VMMouse Commands */
>> -#define VMMOUSE_GETVERSION=C2=A0=C2=A0=C2=A0 10
>> -#define VMMOUSE_DATA=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 39
>> -#define VMMOUSE_STATUS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 40
>> -#define VMMOUSE_COMMAND=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 41
>> -
>> =C2=A0 #define VMMOUSE_READ_ID=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 0x45414552
>> =C2=A0 #define VMMOUSE_DISABLE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 0x000000f5
>> =C2=A0 #define VMMOUSE_REQUEST_RELATIVE=C2=A0=C2=A0=C2=A0 0x4c455252
>> @@ -197,10 +191,10 @@ static uint32_t vmmouse_ioport_read(void=20
>> *opaque, uint32_t addr)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 command =3D data[2] & 0xFFFF;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 switch (command) {
>> -=C2=A0=C2=A0=C2=A0 case VMMOUSE_STATUS:
>> +=C2=A0=C2=A0=C2=A0 case VMPORT_CMD_VMMOUSE_STATUS:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 data[0] =3D vmmou=
se_get_status(s);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>> -=C2=A0=C2=A0=C2=A0 case VMMOUSE_COMMAND:
>> +=C2=A0=C2=A0=C2=A0 case VMPORT_CMD_VMMOUSE_COMMAND:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 switch (data[1]) =
{
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case VMMOUSE_DISA=
BLE:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 vmmouse_disable(s);
>> @@ -219,7 +213,7 @@ static uint32_t vmmouse_ioport_read(void *opaque,=20
>> uint32_t addr)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 break;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>> -=C2=A0=C2=A0=C2=A0 case VMMOUSE_DATA:
>> +=C2=A0=C2=A0=C2=A0 case VMPORT_CMD_VMMOUSE_DATA:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vmmouse_data(s, d=
ata, data[1]);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 default:
>> @@ -276,9 +270,9 @@ static void vmmouse_realizefn(DeviceState *dev,=20
>> Error **errp)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> -=C2=A0=C2=A0=C2=A0 vmport_register(VMMOUSE_STATUS, vmmouse_ioport_read,=
 s);
>> -=C2=A0=C2=A0=C2=A0 vmport_register(VMMOUSE_COMMAND, vmmouse_ioport_read=
, s);
>> -=C2=A0=C2=A0=C2=A0 vmport_register(VMMOUSE_DATA, vmmouse_ioport_read, s=
);
>> +=C2=A0=C2=A0=C2=A0 vmport_register(VMPORT_CMD_VMMOUSE_STATUS, vmmouse_i=
oport_read, s);
>> +=C2=A0=C2=A0=C2=A0 vmport_register(VMPORT_CMD_VMMOUSE_COMMAND, vmmouse_=
ioport_read, s);
>> +=C2=A0=C2=A0=C2=A0 vmport_register(VMPORT_CMD_VMMOUSE_DATA, vmmouse_iop=
ort_read, s);
>> =C2=A0 }
>> =C2=A0 static Property vmmouse_properties[] =3D {
>> diff --git a/hw/i386/vmport.c b/hw/i386/vmport.c
>> index e9ea5fe7f765..6ab094311d6c 100644
>> --- a/hw/i386/vmport.c
>> +++ b/hw/i386/vmport.c
>> @@ -38,10 +38,6 @@
>> =C2=A0 #include "qemu/log.h"
>> =C2=A0 #include "trace.h"
>> -#define VMPORT_CMD_GETVERSION 0x0a
>> -#define VMPORT_CMD_GETRAMSIZE 0x14
>> -
>> -#define VMPORT_ENTRIES 0x2c
>> =C2=A0 #define VMPORT_MAGIC=C2=A0=C2=A0 0x564D5868
>> =C2=A0 /* Compatibility flags for migration */
>> @@ -72,12 +68,9 @@ typedef struct VMPortState {
>> =C2=A0 static VMPortState *port_state;
>> -void vmport_register(unsigned char command, VMPortReadFunc *func,=20
>> void *opaque)
>> +void vmport_register(VMPortCommand command, VMPortReadFunc *func,=20
>> void *opaque)
>> =C2=A0 {
>> -=C2=A0=C2=A0=C2=A0 if (command >=3D VMPORT_ENTRIES) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>> -=C2=A0=C2=A0=C2=A0 }
>> -
>> +=C2=A0=C2=A0=C2=A0 assert(command < VMPORT_ENTRIES);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 trace_vmport_register(command, func, opaq=
ue);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 port_state->func[command] =3D func;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 port_state->opaque[command] =3D opaque;
>> diff --git a/include/hw/i386/vmport.h b/include/hw/i386/vmport.h
>> index f0c1e985ca08..0501ccac6ddf 100644
>> --- a/include/hw/i386/vmport.h
>> +++ b/include/hw/i386/vmport.h
>> @@ -4,12 +4,21 @@
>> =C2=A0 #define TYPE_VMPORT "vmport"
>> =C2=A0 typedef uint32_t (VMPortReadFunc)(void *opaque, uint32_t address)=
;
>> +typedef enum {
>> +=C2=A0=C2=A0=C2=A0 VMPORT_CMD_GETVERSION=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 =3D 10,

Can we rename as VMPORT_CMD_GET_VERSION which is easier to read?

>> +=C2=A0=C2=A0=C2=A0 VMPORT_CMD_GETRAMSIZE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 =3D 20,

Ditto _GET_RAM_SIZE?

>> +=C2=A0=C2=A0=C2=A0 VMPORT_CMD_VMMOUSE_DATA=C2=A0=C2=A0=C2=A0=C2=A0 =3D =
39,
>> +=C2=A0=C2=A0=C2=A0 VMPORT_CMD_VMMOUSE_STATUS=C2=A0=C2=A0 =3D 40,
>> +=C2=A0=C2=A0=C2=A0 VMPORT_CMD_VMMOUSE_COMMAND=C2=A0 =3D 41,
>> +=C2=A0=C2=A0=C2=A0 VMPORT_ENTRIES
>> +} VMPortCommand;
>> +
>> =C2=A0 static inline void vmport_init(ISABus *bus)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 isa_create_simple(bus, TYPE_VMPORT);
>> =C2=A0 }
>> -void vmport_register(unsigned char command, VMPortReadFunc *func,=20
>> void *opaque);
>> +void vmport_register(VMPortCommand command, VMPortReadFunc *func,=20
>> void *opaque);
>> =C2=A0 void vmmouse_get_data(uint32_t *data);
>> =C2=A0 void vmmouse_set_data(const uint32_t *data);
>>


