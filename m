Received: from eggs.gnu.org ([2001:4830:134:3::10]:56468)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1dowFI-0008NB-Rv
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 14:37:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1dowFD-0005Zi-Rt
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 14:37:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47962)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1dowFD-0005Yz-LO
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 14:37:11 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CC6882EC6B2
	for <qemu-devel@nongnu.org>; Mon,  4 Sep 2017 18:37:09 +0000 (UTC)
Date: Tue, 5 Sep 2017 00:07:02 +0530 (IST)
From: P J P <ppandit@redhat.com>
In-Reply-To: <20170901131409.6712-1-kraxel@redhat.com>
Message-ID: <nycvar.YSQ.7.76.1709050001150.31255@wniryva>
References: <20170901131409.6712-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH] wm8750: add record buffer underrun check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

+-- On Fri, 1 Sep 2017, Gerd Hoffmann wrote --+
| diff --git a/hw/audio/wm8750.c b/hw/audio/wm8750.c
| index f8b5bebfc2..d2bf2e1da1 100644
| --- a/hw/audio/wm8750.c
| +++ b/hw/audio/wm8750.c
| @@ -680,8 +680,12 @@ uint32_t wm8750_adc_dat(void *opaque)
|      WM8750State *s = (WM8750State *) opaque;
|      uint32_t *data;
|  
| -    if (s->idx_in >= sizeof(s->data_in))
| +    if (s->idx_in >= sizeof(s->data_in)) {
|          wm8750_in_load(s);
| +        if (s->idx_in >= sizeof(s->data_in)) {
| +            return 0x80008000; /* silence in AUD_FMT_S16 sample format */
| +        }
| +    }
|  
|      data = (uint32_t *) &s->data_in[s->idx_in];
|      s->req_in -= 4;

Ack, looks good. Thank you.
--
Prasad J Pandit / Red Hat Product Security Team
47AF CE69 3A90 54AA 9045 1053 DD13 3D32 FE5B 041F
