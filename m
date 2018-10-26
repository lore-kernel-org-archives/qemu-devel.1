Received: from eggs.gnu.org ([2001:4830:134:3::10]:59596)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gFywG-0002KT-3y
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 06:02:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gFyw7-0001yw-Q8
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 06:01:55 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33043)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gFyw7-0001x2-EX
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 06:01:47 -0400
Received: by mail-wm1-f68.google.com with SMTP id y140-v6so3835693wmd.0
	for <qemu-devel@nongnu.org>; Fri, 26 Oct 2018 03:01:46 -0700 (PDT)
References: <20181025085256.20522-1-kraxel@redhat.com>
	<20181025085256.20522-3-kraxel@redhat.com>
	<7210c7e6-4b85-053c-83c5-524a3b74ef6f@redhat.com>
	<nycvar.YSQ.7.76.1810261458190.8270@xnncv>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6a284fc1-e948-3c32-dba1-9740be5a2d82@redhat.com>
Date: Fri, 26 Oct 2018 12:01:42 +0200
MIME-Version: 1.0
In-Reply-To: <nycvar.YSQ.7.76.1810261458190.8270@xnncv>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/3] adlib: mark as insecure and deprecated.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: P J P <ppandit@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, libvir-list@redhat.com

On 26/10/2018 11:34, P J P wrote:
> +-- On Fri, 26 Oct 2018, Paolo Bonzini wrote --+
> | I am dumb and I don't understand.  In set_ar_dr you get
> | 
> | 	v = 0xff
> | 	ar = 15
> | 	dr = 15
> | 
> | and OPL->AR_TABLE[60] is accessed.  The size of the array is 75, which
> | seems to be actually 14 more than required.  Likewise OPL->DR_TABLE[60]
> | is accessed.
> | 
> | The next accesses use SLOT->ksr which is 0 so it's fine too.
> 
> In set_ar_dr
> 
>   SLOT->AR = ar ? &OPL->AR_TABLE[ar<<2] : RATE_0;
> 
> SLOT->AR is set to point to OPL->DR_TABLE[60] and while so if s->ksr is set to 
> 15, in CALC_FCSLOT()
> 
>   SLOT->evsa = SLOT->AR[ksr];  <= accesses OPL->AR_TABLE[60 + 15];

Oh, thanks!  I said I was dumb. :)  So the fix is just this:

diff --git a/hw/audio/fmopl.h b/hw/audio/fmopl.h
index e7e578a48e..7199afaa3c 100644
--- a/hw/audio/fmopl.h
+++ b/hw/audio/fmopl.h
@@ -72,8 +72,8 @@ typedef struct fm_opl_f {
 	/* Rhythm sention */
 	uint8_t rhythm;		/* Rhythm mode , key flag */
 	/* time tables */
-	int32_t AR_TABLE[75];	/* atttack rate tables */
-	int32_t DR_TABLE[75];	/* decay rate tables   */
+	int32_t AR_TABLE[76];	/* atttack rate tables */
+	int32_t DR_TABLE[76];	/* decay rate tables   */
 	uint32_t FN_TABLE[1024];  /* fnumber -> increment counter */
 	/* LFO */
 	int32_t *ams_table;

and init_timetables will just fill it with the right value?  (I checked
against another implementation at http://opl3.cozendey.com/).

Thanks,

Paolo
