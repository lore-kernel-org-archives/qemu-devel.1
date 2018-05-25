Received: from eggs.gnu.org ([2001:4830:134:3::10]:53692)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fM980-0003B7-3P
	for qemu-devel@nongnu.org; Fri, 25 May 2018 05:35:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fM97z-0008FI-CX
	for qemu-devel@nongnu.org; Fri, 25 May 2018 05:35:16 -0400
Received: from mail-oi0-x234.google.com ([2607:f8b0:4003:c06::234]:37852)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fM97y-0008EJ-W1
	for qemu-devel@nongnu.org; Fri, 25 May 2018 05:35:15 -0400
Received: by mail-oi0-x234.google.com with SMTP id w123-v6so4033738oia.4
	for <qemu-devel@nongnu.org>; Fri, 25 May 2018 02:35:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5f966d9b-1eb9-f447-69bc-2d93df4c6d2b@redhat.com>
References: <20180521140402.23318-1-peter.maydell@linaro.org>
	<20180521140402.23318-15-peter.maydell@linaro.org>
	<20180522030333.GB17282@xz-mi>
	<CAFEAcA-iOYhuPfvDv+iD6jBqXMXqN-jfTpSSBub1Zp1i-JcDbQ@mail.gmail.com>
	<20180522110236.GB31932@xz-mi>
	<CAFEAcA9b6dmpj+B=SO2YsB5sXsh=UPjkjN_U0i-uJhiDn20HHw@mail.gmail.com>
	<20180523010636.GC31932@xz-mi>
	<CAFEAcA840qn7Ms9hph9zzZgMbL8C7kN=cs4esGO9kxGXsgBg1A@mail.gmail.com>
	<20180524062352.GA12122@xz-mi>
	<CAFEAcA9SXirTw=H3wznVZDTmO1OB-LRNJAQ1MsyYm62SqvMqRQ@mail.gmail.com>
	<5f966d9b-1eb9-f447-69bc-2d93df4c6d2b@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 25 May 2018 10:34:53 +0100
Message-ID: <CAFEAcA_emEZrZk61xyJEY=R_dAtB0yfg_3ML_zQFbS0dWC9XLw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 14/27] iommu: Add IOMMU index concept to
 IOMMU API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Auger Eric <eric.auger@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, "patches@linaro.org" <patches@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Alex Williamson <alex.williamson@redhat.com>, qemu-arm <qemu-arm@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Richard Henderson <rth@twiddle.net>

On 25 May 2018 at 10:27, Auger Eric <eric.auger@redhat.com> wrote:
> I fail to understand the PRIV attribute usage in SMMUv3.
> My understanding is the STRW (ie. stream world, kind of indication of
> the exception level the SID is used along) in the STE is used to
> determine the correct TTB*. Isn't PRIV checked against the page table
> attributes only?

I haven't looked too closely at the details for the SMMUv3.
But basically if you can return different results for
"transaction is priv" vs "transaction is user" then you need
separate iommu indexes, even if the only difference might
be in the permissions. (This is because an IOMMUTLBEntry
can only specify one set of r/w permissions; it can't
tell you the permissions separately for priv vs user.) If the
SMMUv3 always reports the same permissions and address regardless
of the transaction's priv attribute, then it doesn't need
to use separate indexes for them.

thanks
-- PMM
