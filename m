Received: from eggs.gnu.org ([2001:4830:134:3::10]:54561)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fWHth-00078M-Oj
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 04:58:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fWHtc-0007G1-Me
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 04:58:25 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:35623)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fWHtc-0007Ed-G6
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 04:58:20 -0400
Received: by mail-wr0-x243.google.com with SMTP id y12-v6so910627wrs.2
	for <qemu-devel@nongnu.org>; Fri, 22 Jun 2018 01:58:20 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20180620132546.27128-1-pbonzini@redhat.com>
	<b3034f45-18f4-eb6d-3553-82d777f30777@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7f6f37a7-538c-e7f9-5092-9ca9329153ae@redhat.com>
Date: Fri, 22 Jun 2018 10:58:18 +0200
MIME-Version: 1.0
In-Reply-To: <b3034f45-18f4-eb6d-3553-82d777f30777@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: kraxel@redhat.com

On 21/06/2018 22:06, John Snow wrote:
> 
> On 06/20/2018 09:25 AM, Paolo Bonzini wrote:
>> +    pio_fis_i = is_atapi ? ad->done_atapi_packet : !is_write;
> Per DPIOO1, does this go to false for the first DRQ block, or did I
> misunderstand? Currently my understanding:

DPIOO1 is the !is_atapi && is_write case, where I is currently always 0.
 When do we have more than one DRQ block, is it for multi-sector PIO
reads?  Then perhaps we need something like ad->command->done_first_pio.

Paolo

> - device->host
> 	DPIOI1
> 	Interrupt bit shall be set.
> - host->device:
> 	DPIOO1:
> 	0 for first block, 1 otherwise
> - ATAPI:
> 	0 for packet itself
> 	1 for all data otherwise.
