Return-Path: <SRS0=q9Vo=YU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70D3ACA9EAF
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Oct 2019 18:38:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 437BA20717
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Oct 2019 18:38:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mvista-com.20150623.gappssmtp.com header.i=@mvista-com.20150623.gappssmtp.com header.b="XQASbqhc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 437BA20717
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mvista.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46566 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iOnQj-0002wq-31
	for qemu-devel@archiver.kernel.org; Sun, 27 Oct 2019 14:38:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36040)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cminyard@mvista.com>) id 1iOnMa-0006DE-Sb
 for qemu-devel@nongnu.org; Sun, 27 Oct 2019 14:34:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cminyard@mvista.com>) id 1iOnMQ-0007gr-WF
 for qemu-devel@nongnu.org; Sun, 27 Oct 2019 14:33:58 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:33998)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <cminyard@mvista.com>) id 1iOnMQ-0007ek-RT
 for qemu-devel@nongnu.org; Sun, 27 Oct 2019 14:33:54 -0400
Received: by mail-oi1-x242.google.com with SMTP id 83so4660568oii.1
 for <qemu-devel@nongnu.org>; Sun, 27 Oct 2019 11:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mvista-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=Tmq9bulObTdaF5sXKPDFhGXqmLeYrDhCV2UTByzDRhc=;
 b=XQASbqhcd1Ns0b2TxcGtKVMV/cNI/OwvN0z/n65eQ5XPIt2OHT8zB5s51aU34o8MVa
 4SNVA+2gXR/pZ7zhAxZO3ISeMyul2iWIdSFMtq2pk+2rYnQviBXrwbbJPCTw1N8pPRim
 u1hg7ZGnN4DbD6iXdPemQI31ekBpZYXcd7ZQzJb8x6wYRJeRlkn9I0P+xZjptK4t6BJP
 Sy+gxCGDW2/72yDVwRTpWJfpO860JvxmDOTEQeknBGdRjQDURK4Oa/FDsV5ot2TlBia0
 PnMR7eWlL5jgZaVNh2B7aZT4ju0yAsIXdNE13Bh/msCvtG2eZU3acd6oC2ssEK8Tgomm
 sRow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
 :references:mime-version:content-disposition
 :content-transfer-encoding:in-reply-to:user-agent;
 bh=Tmq9bulObTdaF5sXKPDFhGXqmLeYrDhCV2UTByzDRhc=;
 b=cYOVozWeYxxnTEgCYJVjKSB4l2brkp8ew1HQiI/YNkdtvnb5Secz3wkVECEwfx062z
 WJRc+lxFGJAgeMrFgvAWs/cnzewMSYfl/qPEcTFwgCwDZiYuU4HArsK2N81hhSiymvEM
 x5kDdH+MS/2vy9rqRKT3bXfJ4TwE+F9gzp2K5E/YYrreSMF5NsF+QIlHip0bp/RKk9Bc
 UJp3TV3O6iXnLca4uvJJS4NRmHV4ZFOdyxtf0rM3KP1WUkYVmmwRpouRR4M2M/7E0PfV
 XHljo50F6CZcM/B3XNjm1TPrZq1nTdpPWdXvJCmFSvc70H0DxFRe+Mia8XuomDnwQQOF
 f33A==
X-Gm-Message-State: APjAAAVKcd9MY9HsoCkrg0UC5PUFnFWBmjm/fYd5POBi/0UxJ7G2c/Di
 4/Ec2AaL7q0LG4y6yMqd5lL/zA==
X-Google-Smtp-Source: APXvYqxnhcFs5Lza3tXqTKo2ckO4/9BlhAAGRf4qJXIhG9inEImm2Jw0aIEKm6brzvzKPQ4i1V6SbQ==
X-Received: by 2002:a05:6808:249:: with SMTP id
 m9mr11357126oie.49.1572201230975; 
 Sun, 27 Oct 2019 11:33:50 -0700 (PDT)
Received: from minyard.net ([47.184.136.59])
 by smtp.gmail.com with ESMTPSA id l12sm2347005oii.48.2019.10.27.11.33.49
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 27 Oct 2019 11:33:49 -0700 (PDT)
Date: Sun, 27 Oct 2019 13:33:47 -0500
From: Corey Minyard <cminyard@mvista.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 2/5] ipmi: Add support to customize OEM functions
Message-ID: <20191027183347.GC2461@minyard.net>
References: <20191021131215.3693-1-clg@kaod.org>
 <20191021131215.3693-3-clg@kaod.org> <20191021143017.GH25427@t560>
 <20191027174739.GN3552@umbus.metropole.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191027174739.GN3552@umbus.metropole.lan>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
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
Reply-To: cminyard@mvista.com
Cc: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Joel Stanley <joel@jms.id.au>, "Marty E . Plummer" <hanetzer@startmail.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Oct 27, 2019 at 06:47:39PM +0100, David Gibson wrote:
> On Mon, Oct 21, 2019 at 09:30:17AM -0500, Corey Minyard wrote:
> > On Mon, Oct 21, 2019 at 03:12:12PM +0200, Cédric Le Goater wrote:
> > > The routine ipmi_register_oem_netfn() lets external modules register
> > > command handlers for OEM functions. Required for the PowerNV machine.
> > 
> > Comments inline.
> > 
> > > 
> > > Cc: Corey Minyard <cminyard@mvista.com>
> > > Signed-off-by: Cédric Le Goater <clg@kaod.org>
> > > ---
> > >  include/hw/ipmi/ipmi.h | 36 ++++++++++++++++++++++++++++++++++++
> > >  hw/ipmi/ipmi_bmc_sim.c | 41 ++++++-----------------------------------
> > >  2 files changed, 42 insertions(+), 35 deletions(-)
> > > 
> > > diff --git a/include/hw/ipmi/ipmi.h b/include/hw/ipmi/ipmi.h
> > > index 6f2413b39b4a..cb7203b06767 100644
> > > --- a/include/hw/ipmi/ipmi.h
> > > +++ b/include/hw/ipmi/ipmi.h
> > > @@ -265,4 +265,40 @@ int ipmi_bmc_sdr_find(IPMIBmc *b, uint16_t recid,
> > >                        const struct ipmi_sdr_compact **sdr, uint16_t *nextrec);
> > >  void ipmi_bmc_gen_event(IPMIBmc *b, uint8_t *evt, bool log);
> > >  
> > > +typedef struct IPMIBmcSim IPMIBmcSim;
> > 
> > This type isn't very useful outside of the simulator, but changes for
> > that can come as they are needed.  I don't see an easy way to avoid
> > putting it here.
> > 
> > > +
> > > +typedef struct RspBuffer {
> > > +    uint8_t buffer[MAX_IPMI_MSG_SIZE];
> > > +    unsigned int len;
> > > +} RspBuffer;
> > > +
> > > +static inline void rsp_buffer_set_error(RspBuffer *rsp, uint8_t byte)
> > > +{
> > > +    rsp->buffer[2] = byte;
> > > +}
> > > +
> > > +/* Add a byte to the response. */
> > > +static inline void rsp_buffer_push(RspBuffer *rsp, uint8_t byte)
> > > +{
> > > +    if (rsp->len >= sizeof(rsp->buffer)) {
> > > +        rsp_buffer_set_error(rsp, IPMI_CC_REQUEST_DATA_TRUNCATED);
> > > +        return;
> > > +    }
> > > +    rsp->buffer[rsp->len++] = byte;
> > > +}
> > > +
> > > +typedef struct IPMICmdHandler {
> > > +    void (*cmd_handler)(IPMIBmcSim *s,
> > > +                        uint8_t *cmd, unsigned int cmd_len,
> > > +                        RspBuffer *rsp);
> > > +    unsigned int cmd_len_min;
> > > +} IPMICmdHandler;
> > > +
> > > +typedef struct IPMINetfn {
> > > +    unsigned int cmd_nums;
> > > +    const IPMICmdHandler *cmd_handlers;
> > > +} IPMINetfn;
> > > +
> > > +int ipmi_register_oem_netfn(IPMIBmc *b, const IPMINetfn *netfnd);
> > > +
> > >  #endif
> > > diff --git a/hw/ipmi/ipmi_bmc_sim.c b/hw/ipmi/ipmi_bmc_sim.c
> > > index 71e56f3b13d1..770aace55b08 100644
> > > --- a/hw/ipmi/ipmi_bmc_sim.c
> > > +++ b/hw/ipmi/ipmi_bmc_sim.c
> > > @@ -98,6 +98,7 @@
> > >  #define IPMI_CMD_GET_SEL_TIME             0x48
> > >  #define IPMI_CMD_SET_SEL_TIME             0x49
> > >  
> > > +#define IPMI_NETFN_OEM                    0x3a
> > >  
> > >  /* Same as a timespec struct. */
> > >  struct ipmi_time {
> > > @@ -167,23 +168,8 @@ typedef struct IPMISensor {
> > >  #define MAX_SENSORS 20
> > >  #define IPMI_WATCHDOG_SENSOR 0
> > >  
> > > -typedef struct IPMIBmcSim IPMIBmcSim;
> > > -typedef struct RspBuffer RspBuffer;
> > > -
> > >  #define MAX_NETFNS 64
> > >  
> > > -typedef struct IPMICmdHandler {
> > > -    void (*cmd_handler)(IPMIBmcSim *s,
> > > -                        uint8_t *cmd, unsigned int cmd_len,
> > > -                        RspBuffer *rsp);
> > > -    unsigned int cmd_len_min;
> > > -} IPMICmdHandler;
> > > -
> > > -typedef struct IPMINetfn {
> > > -    unsigned int cmd_nums;
> > > -    const IPMICmdHandler *cmd_handlers;
> > > -} IPMINetfn;
> > > -
> > >  typedef struct IPMIRcvBufEntry {
> > >      QTAILQ_ENTRY(IPMIRcvBufEntry) entry;
> > >      uint8_t len;
> > > @@ -279,28 +265,8 @@ struct IPMIBmcSim {
> > >  #define IPMI_BMC_WATCHDOG_ACTION_POWER_DOWN      2
> > >  #define IPMI_BMC_WATCHDOG_ACTION_POWER_CYCLE     3
> > >  
> > > -struct RspBuffer {
> > > -    uint8_t buffer[MAX_IPMI_MSG_SIZE];
> > > -    unsigned int len;
> > > -};
> > > -
> > >  #define RSP_BUFFER_INITIALIZER { }
> > >  
> > > -static inline void rsp_buffer_set_error(RspBuffer *rsp, uint8_t byte)
> > > -{
> > > -    rsp->buffer[2] = byte;
> > > -}
> > > -
> > > -/* Add a byte to the response. */
> > > -static inline void rsp_buffer_push(RspBuffer *rsp, uint8_t byte)
> > > -{
> > > -    if (rsp->len >= sizeof(rsp->buffer)) {
> > > -        rsp_buffer_set_error(rsp, IPMI_CC_REQUEST_DATA_TRUNCATED);
> > > -        return;
> > > -    }
> > > -    rsp->buffer[rsp->len++] = byte;
> > > -}
> > > -
> > >  static inline void rsp_buffer_pushmore(RspBuffer *rsp, uint8_t *bytes,
> > >                                         unsigned int n)
> > >  {
> > > @@ -640,6 +606,11 @@ static int ipmi_register_netfn(IPMIBmcSim *s, unsigned int netfn,
> > >      return 0;
> > >  }
> > >  
> > > +int ipmi_register_oem_netfn(IPMIBmc *b, const IPMINetfn *netfnd)
> > > +{
> > > +    return ipmi_register_netfn(IPMI_BMC_SIMULATOR(b), IPMI_NETFN_OEM, netfnd);
> > > +}
> > 
> > I think I would prefer just exposing ipmi_register_netfn() and maybe
> > rename it ipmi_sim_register_netfn() or something like that.  There may
> > be other netfns needed in the future.
> > 
> > But with that change, this looks good to me:
> > 
> > Reviewed-by: Corey Minyard <cminyard@mvista.com>
> 
> What's the plan for merging this, once it's ready?  Is there an IPMI
> tree for it to be staged in?  If not I could take it through the ppc
> tree, but I'd need some Acked-bys in that case.

I have an IPMI tree for this.  I was assuming it was going in to the PPC
tree, but it's not big deal.

-corey

> 
> > 
> > > +
> > >  static const IPMICmdHandler *ipmi_get_handler(IPMIBmcSim *ibs,
> > >                                                unsigned int netfn,
> > >                                                unsigned int cmd)
> > 
> 
> -- 
> David Gibson			| I'll have my music baroque, and my code
> david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
> 				| _way_ _around_!
> http://www.ozlabs.org/~dgibson



