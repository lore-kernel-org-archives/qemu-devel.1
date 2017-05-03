Received: from eggs.gnu.org ([2001:4830:134:3::10]:47523)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ytht.net@gmail.com>) id 1d5z7F-00058x-L4
	for qemu-devel@nongnu.org; Wed, 03 May 2017 14:35:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ytht.net@gmail.com>) id 1d5z7E-0004b8-SX
	for qemu-devel@nongnu.org; Wed, 03 May 2017 14:35:09 -0400
Received: from mail-it0-x243.google.com ([2607:f8b0:4001:c0b::243]:33778)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ytht.net@gmail.com>) id 1d5z7E-0004X7-OE
	for qemu-devel@nongnu.org; Wed, 03 May 2017 14:35:08 -0400
Received: by mail-it0-x243.google.com with SMTP id v135so7116876itv.0
	for <qemu-devel@nongnu.org>; Wed, 03 May 2017 11:35:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170427132126.lkdi5owqezvlp6o2@var.youpi.perso.aquilenet.fr>
References: <20170420204301.154912-1-lepton@google.com>
	<42f99074-9330-c974-e884-f0a62e63c697@redhat.com>
	<20170427132126.lkdi5owqezvlp6o2@var.youpi.perso.aquilenet.fr>
From: lepton <ytht.net@gmail.com>
Date: Wed, 3 May 2017 11:35:05 -0700
Message-ID: <CALqoU4xQPynFnXH86z7+kw9fQ-3zFfesScMRYcK885HXMKKK5w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH 1/1] slirp: don't zero ti_i since we
 acccess it later.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Thibault <samuel.thibault@gnu.org>
Cc: Tao Wu <lepton@google.com>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org

Hi Samuel,

Should I add an assert for ih_x1?  It sounds like a bug that  caller set up
a right src and dst address and without set right ih_x1.

On Thu, Apr 27, 2017 at 6:21 AM, Samuel Thibault <samuel.thibault@gnu.org>
wrote:

> Hello,
>
> Thomas Huth, on lun. 24 avril 2017 11:15:56 +0200, wrote:
> > On 20.04.2017 22:43, Tao Wu wrote:
> > > The current code looks buggy, we zero ti_i while we access
> > > ti_dst/ti_src later.
>
> Indeed.
>
> > > Signed-off-by: Tao Wu <lepton@google.com>
>
> > >             *mtod(m, struct tcpiphdr *) = *ti;
> > >             ti = mtod(m, struct tcpiphdr *);
> > > -           memset(&ti->ti, 0, sizeof(ti->ti));
>
> But then we don't make sure that ih_x1 is 0, which is needed for the
> checksum to be correct, but possibly not set by the caller.
>
> So please replace the memset call with setting the proper ih_x1 field to
> 0 (which thus needs the introductino of a switch over af like below in
> the code).
>
> Samuel
>
