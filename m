Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EDC1C33CB1
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 16:17:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A3C4206D5
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 16:17:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="i19iVcqe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A3C4206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44480 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1is7pv-0005zl-5F
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 11:17:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39627)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <qemu_oss@crudebyte.com>) id 1is7oa-0005Tc-Ie
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 11:16:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <qemu_oss@crudebyte.com>) id 1is7oZ-00071H-16
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 11:16:12 -0500
Received: from kylie.crudebyte.com ([5.189.157.229]:41287)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <qemu_oss@crudebyte.com>)
 id 1is7oY-0006zE-IT
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 11:16:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=02TWnZHkJKxN+FHb0XyRdbekVWgKE2w3sqX1AAiYtmA=; b=i19iVcqe0/Db7NjCZn1oKf7ZpJ
 9QKx1zKg6+psk2cWFfHtdDNu8yYcAO3Qx5/1wc00uJ06Ty0UpGXh24YSO08NmARCrlD0yq4HpXjDh
 OBxdGfsXjT0ri9ruuNoFD8zT8dnVt7TfR+4KG1SAAg4YR+HE2TvfpFK3x2w64c6h4JW9TGqG8HFjX
 YqXzw7f4mlGIEfECbWpvupCD5SKEDvT5MWdiAceaP7o4gqxLG2g+/noJYB+EvPqL1dze3n6iE0YoH
 aX3GV7wabZDJY5mlh79ksXluUbKbjAHy0EJ7DTavdf2LmtW9p48VH4Lp8hLV0wioML57z5LyaO5vs
 rTd8k4pTbRHNcs3XJigJQGGWxs2u+ZwrkdWtAxFNetj0TOSWuWuMo24VFuDX5aSR5htyn1iCu/X34
 rKIAWvFlJqSZbp8OdygV0D2MfpS6NSNfFDnKqOzd7EXuZFTrrvYwfDezh3RMxgXiB2HrINBfd6bf6
 6JefQt7R+w6HUq5zzCJZ23b86BT7hjV35ogv6xUKnBlap7/KX1vPOeCuS6Z3fao2dFVznxmx8n+IV
 rhbcqfklOxps6EPhKx/atbg+06etCY2XplftgnmeoFvPvwlOuNXhAbQGa2Z/WuKns2LpCZYXNLq5s
 Xv/LQ6h0Oqx7SENITQ9VaHzlVooGdTEYBXSR/Ux60=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>, Christian Schoenebeck <qemu_oss@crudebyte.com>
Subject: Re: [PATCH v3 02/11] 9pfs: require msize >= 4096
Date: Thu, 16 Jan 2020 17:16:07 +0100
Message-ID: <2705438.6bQikqVx44@silver>
In-Reply-To: <20200116141503.32e36561@bahia.lan>
References: <cover.1578957500.git.qemu_oss@crudebyte.com>
 <49ff399635ccfd21858b15417a398df362ff0b90.1578957500.git.qemu_oss@crudebyte.com>
 <20200116141503.32e36561@bahia.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 5.189.157.229
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Donnerstag, 16. Januar 2020 14:15:03 CET Greg Kurz wrote:
> On Mon, 13 Jan 2020 23:21:04 +0100
> 
> Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:
> > A client establishes a session by sending a Tversion request along with
> > a 'msize' parameter which client uses to suggest server a maximum
> > message size ever to be used for communication (for both requests and
> > replies) between client and server during that session. If client
> > suggests a 'msize' smaller than 4096 then deny session by server
> > immediately with an error response (Rlerror for "9P2000.L" clients or
> > Rerror for "9P2000.u" clients) instead of replying with Rversion.
> > 
> > Introduction of a minimum msize is required to prevent issues in
> > responses to numerous individual request types. For instance with a
> > msize of < P9_IOHDRSZ no useful operations would be possible at all.
> 
> P9_IOHDRSZ is really specific to write/read operations.
> 
> /*
>  * ample room for Twrite/Rread header
>  * size[4] Tread/Twrite tag[2] fid[4] offset[8] count[4]
>  */
> #define P9_IOHDRSZ 24
> 
> As you see P9_IOHDRSZ is approximately the size of a Twrite header.
> Its primary use is to inform the client about the 'count' to use for
> Twrite/Tread messages (see get_iounit()).
> 
> Not sure it helps to mention P9_IOHDRSZ since we're going to choose
> something much greater. I'd personally drop this sentence.

The point here was that there must be some kind of absolute minimum msize, 
even though the protocol specs officially don't mandate one. And if a client 
choses a msize < P9_IOHDRSZ, what useful actions shall it be able to do? 
That's why I mentioned P9_IOHDRSZ just in case somebody might come up later 
asking to lower that minimum msize value for whatever reason.

But np, IMO this sentence makes the fundamental requirement for this patch 
more clear, but I have no problem dropping this sentence.

> > Furthermore there are some responses which are not allowed by the 9p
> > protocol to be truncated like e.g. Rreadlink which may yield up to
> 
> No message may be truncated in any way actually. The spec just allows
> an exception with the string part of Rerror.

Rreaddir, Rread, Twrite, Rerror can be truncated. So I suggest I'll just 
change that to s/some/most/ semantically.

> Maybe just mention that and say we choose 4096 to be able to send
> big Rreadlink messages.

That's not the point for this patch. The main purpose is to avoid having to 
maintain individual error prone minimum msize checks all over the code base.
If we would allow very small msizes (much smaller than 4096), then we would 
need to add numerous error handlers all over the code base, each one checking 
for different values (depending on the specific message type).

> > a size of PATH_MAX which is usually 4096. Hence this size was chosen
> > as min. msize for server, which is already the minimum msize of the
> > Linux kernel's 9pfs client. By forcing a min. msize already at
> > session start (when handling Tversion) we don't have to check for a
> > minimum msize on a per request type basis later on during session,
> > which would be much harder and more error prone to maintain.
> > 
> > This is a user visible change which should be documented as such
> > (i.e. in public QEMU release changelog).
> 
> This last sentence isn't informative in the commit message. This
> kind of indication should be added after the --- below.
> 
> > Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> > ---

np

> 
> LGTM
> 
> With an updated changelog,
> 
> Reviewed-by: Greg Kurz <groug@kaod.org>
> 
> >  hw/9pfs/9p.c | 12 ++++++++++++
> >  hw/9pfs/9p.h | 11 +++++++++++
> >  2 files changed, 23 insertions(+)
> > 
> > diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
> > index 520177f40c..a5fbe821d4 100644
> > --- a/hw/9pfs/9p.c
> > +++ b/hw/9pfs/9p.c
> > @@ -1363,8 +1363,20 @@ static void coroutine_fn v9fs_version(void *opaque)
> > 
> >          s->proto_version = V9FS_PROTO_2000L;
> >      
> >      } else {
> >      
> >          v9fs_string_sprintf(&version, "unknown");
> > 
> > +        /* skip min. msize check, reporting invalid version has priority
> > */ +        goto marshal;
> > 
> >      }
> > 
> > +    if (s->msize < P9_MIN_MSIZE) {
> > +        err = -EMSGSIZE;
> > +        error_report(
> > +            "9pfs: Client requested msize < minimum msize ("
> > +            stringify(P9_MIN_MSIZE) ") supported by this server."
> > +        );
> > +        goto out;
> > +    }
> > +
> > 
> > +marshal:
> >      err = pdu_marshal(pdu, offset, "ds", s->msize, &version);
> >      if (err < 0) {
> >      
> >          goto out;
> > 
> > diff --git a/hw/9pfs/9p.h b/hw/9pfs/9p.h
> > index 3904f82901..6fffe44f5a 100644
> > --- a/hw/9pfs/9p.h
> > +++ b/hw/9pfs/9p.h
> > @@ -100,6 +100,17 @@ typedef enum P9ProtoVersion {
> > 
> >      V9FS_PROTO_2000L = 0x02,
> >  
> >  } P9ProtoVersion;
> > 
> > +/**
> > + * @brief Minimum message size supported by this 9pfs server.
> > + *
> > + * A client establishes a session by sending a Tversion request along
> > with a + * 'msize' parameter which suggests the server a maximum message
> > size ever to be + * used for communication (for both requests and
> > replies) between client and + * server during that session. If client
> > suggests a 'msize' smaller than this + * value then session is denied by
> > server with an error response. + */
> > +#define P9_MIN_MSIZE    4096
> > +
> > 
> >  #define P9_NOTAG    UINT16_MAX
> >  #define P9_NOFID    UINT32_MAX
> >  #define P9_MAXWELEM 16

Best regards,
Christian Schoenebeck



