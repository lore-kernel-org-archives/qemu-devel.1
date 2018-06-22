Received: from eggs.gnu.org ([2001:4830:134:3::10]:43898)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fWOts-0002Bc-Df
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 12:27:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fWOtp-0001qn-7y
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 12:27:04 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57766 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1fWOtp-0001qM-2T
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 12:27:01 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7672A40AC6DF
	for <qemu-devel@nongnu.org>; Fri, 22 Jun 2018 16:26:59 +0000 (UTC)
References: <20180620132546.27128-1-pbonzini@redhat.com>
	<b3034f45-18f4-eb6d-3553-82d777f30777@redhat.com>
	<7f6f37a7-538c-e7f9-5092-9ca9329153ae@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <7d85b42b-89de-a8f1-c49d-945e392cf02c@redhat.com>
Date: Fri, 22 Jun 2018 12:26:57 -0400
MIME-Version: 1.0
In-Reply-To: <7f6f37a7-538c-e7f9-5092-9ca9329153ae@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] ahci: fix FIS I bit and PIO Setup FIS
 interrupt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: kraxel@redhat.com



On 06/22/2018 04:58 AM, Paolo Bonzini wrote:
> On 21/06/2018 22:06, John Snow wrote:
>>
>> On 06/20/2018 09:25 AM, Paolo Bonzini wrote:
>>> +    pio_fis_i =3D is_atapi ? ad->done_atapi_packet : !is_write;
>> Per DPIOO1, does this go to false for the first DRQ block, or did I
>> misunderstand? Currently my understanding:
>=20
> DPIOO1 is the !is_atapi && is_write case, where I is currently always 0=
.
>  When do we have more than one DRQ block, is it for multi-sector PIO
> reads?  Then perhaps we need something like ad->command->done_first_pio=
.
>=20
> Paolo
>=20

cmd_read_pio: req_nb_sectors =3D 1
ide_sector_read:
	sector_num =3D ide_get_sector(s) (LBA offset)
	n =3D s->nsector (1 or more sectors)
	but then we clamp it to s->req_nb_sectors, which is 1 here,
	then we build an SGlist pointed to s->io_buffer;

s->io_buffer_total_len =3D IDE_DMA_BUF_SECTORS*512 + 4;

Oh, actually our buffer here is quite big, 256 sectors plus four extra
bytes that Fabrice never explained.

Max request size for lba28 is going to be 256 sectors on the button, but
64K for lba48. I don't remember immediately if there is some
spec-mandated limit on how large a single DRQ block can be for PATA or SA=
TA.

IDENTIFY Word 47 specifies how many for READ/WRITE Multiple, so I'm
intuiting here that READ/WRITE implicitly mandate one sector per DRQ bloc=
k.

>> - device->host
>> 	DPIOI1
>> 	Interrupt bit shall be set.
>> - host->device:
>> 	DPIOO1:
>> 	0 for first block, 1 otherwise
>> - ATAPI:
>> 	0 for packet itself
>> 	1 for all data otherwise.
>=20

--=20
=E2=80=94js
