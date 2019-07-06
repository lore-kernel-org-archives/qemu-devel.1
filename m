Return-Path: <SRS0=Pmsr=VD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E487C5B578
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jul 2019 23:00:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CF3C20836
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jul 2019 23:00:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mvista-com.20150623.gappssmtp.com header.i=@mvista-com.20150623.gappssmtp.com header.b="0pjuXnbG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CF3C20836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mvista.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjtfF-0002Vs-67
	for qemu-devel@archiver.kernel.org; Sat, 06 Jul 2019 19:00:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33603)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <cminyard@mvista.com>) id 1hjtdH-0001Sz-J0
 for qemu-devel@nongnu.org; Sat, 06 Jul 2019 18:58:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cminyard@mvista.com>) id 1hjtd9-0003Rl-Ub
 for qemu-devel@nongnu.org; Sat, 06 Jul 2019 18:58:15 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:34074)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <cminyard@mvista.com>) id 1hjtd0-0003MZ-Tf
 for qemu-devel@nongnu.org; Sat, 06 Jul 2019 18:58:03 -0400
Received: by mail-oi1-x243.google.com with SMTP id l12so9767409oil.1
 for <qemu-devel@nongnu.org>; Sat, 06 Jul 2019 15:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mvista-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=/hOe8dS3LNkNRWKM8RxSE9Cog/pL1+yLI+k6RTnALkk=;
 b=0pjuXnbGqFg4iC2fl+YrfD2T0WfyyaD145GWl8+kEc/73q/+tqR6kJnP3zcyY0kkm7
 fcuDOZCwO99aKAR8zDKNKiwuBPNHQaXzw0YKajDjKUPNfvgHlkuRma58WWoWkjsWIn+S
 6Owz7+1+Q4koEU+26DKX80wM4m9iVkH6KNMxBmqra18CUbv5T4UOEzEn1VFci/OPNhfi
 i/6dzpu5t0qFJXC83kvQVPHPwcsKUG9rvdqtAuJ01oqaZfNwa48iGLVIGTIE8pR633Ud
 VX/d2VMEQmA8U9K34YP16RtQtX7WOWvJV6oTLS+OGYpBUOih/+xm4GASPNbpbHyp16No
 a/jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
 :references:mime-version:content-disposition
 :content-transfer-encoding:in-reply-to:user-agent;
 bh=/hOe8dS3LNkNRWKM8RxSE9Cog/pL1+yLI+k6RTnALkk=;
 b=X1DnxLeJ1rr29PyTvOonC5sCCq+iXD7nc6PsexBl4qSlKsyui1xEl6UrLnQawJs3cp
 xi8vAzDcXrg4x7dMz2CbsAsqz8nC0QVo33Qx9qdtS8bDglIUgrg3hSMgVEcCLkM8d0cI
 P90S1vaX68Ryw6nFLuyz9un7uyJ0CZr28+xdi5r+cwWLb4ujHK27AMS0x4Oyl6qim4t3
 jbOZxeufimtfuMAjYlQt/kUJZbxGfZrkLe4E8KhZsuxCx+9W/2lo+cMbbYPiNlHztBTi
 La285vAxYm1C49JDoA+a7o11wn2Kh9lZluhBKi3lDG5g+U5pyhTXUtKQCzfGiPtYAi3g
 6YDQ==
X-Gm-Message-State: APjAAAX77EokwzKwv70qdbQeYQ03qqp9P23MspUUgSR1goC4abhd49XT
 Sww3gzm9xsecC8PKGAACyy/aJw==
X-Google-Smtp-Source: APXvYqxzXfbQJaspj6W3iDfXiD8HQkXeniN5FglvEi+HejyvwNzpW7lUoibfgJzYh+sp4RqqMvLYbQ==
X-Received: by 2002:aca:a884:: with SMTP id r126mr5797180oie.11.1562453868280; 
 Sat, 06 Jul 2019 15:57:48 -0700 (PDT)
Received: from minyard.net ([2001:470:b8f6:1b:7818:f71b:7070:b965])
 by smtp.gmail.com with ESMTPSA id s4sm4577349otp.3.2019.07.06.15.57.47
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sat, 06 Jul 2019 15:57:47 -0700 (PDT)
Date: Sat, 6 Jul 2019 17:57:45 -0500
From: Corey Minyard <cminyard@mvista.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190706225745.GG4336@minyard.net>
References: <20190701183100.7849-1-minyard@acm.org>
 <20190701183100.7849-3-minyard@acm.org>
 <20190703142625.GD23082@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190703142625.GD23082@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
Subject: Re: [Qemu-devel] [PATCH v2 2/2] ipmi: Add a UUID device property
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 QEMU Developers <qemu-devel@nongnu.org>,
 "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jul 03, 2019 at 03:26:25PM +0100, Daniel P. Berrangé wrote:
> On Mon, Jul 01, 2019 at 01:31:00PM -0500, minyard@acm.org wrote:
> > From: Corey Minyard <cminyard@mvista.com>
> > 
> > Using the UUID that qemu generates probably isn't the best thing
> > to do, allow it to be passed in via properties, and use QemuUUID
> > for the type.
> 
> AFAICT, QEMU isn't generating a UUID in the current code.

Yeah, it doesn't appear to.

> 
> The device is taking the UUID that the user has set
> explicitly via the --uuid argument to QEMU. If --uuid
> is not set, then it is leaving it all zeros.
> 
> Defaulting to the UUID from --uuid looks quite reasonable
> to me & I don't think we should break that current usage.

I originally thought that, but thinking it through some more,
that's not the way real systems work.  The system UUID and the
BMC UUID are generally (probably always) different.

Plus, defaulting it to the system UUID might result in a
surprise for the user.  In retrospect, I think it's better
to leave the UUID unset unless explicitly set by the user.

> 
> I can see justification for being able to further override
> that default with a device level property though.
> 
> 
> > If the UUID is not set, return an unsupported command error.  This
> > way we are not providing an all-zero (or randomly generated) GUID
> > to the IPMI user.  This lets the host fall back to the other
> > method of using the get device id command to determind the BMC
> > being accessed.
> 
> Reporting an error would be a guest ABI regression from current QEMU
> behaviour for anyone who is using the IPMI device right now, without
> --uuid.

Actually, it would only be a regression for anyone using --uuid.  If
the system UUID is all zero, then it will return an error currently.

> 
> I'm not sure how much we care about guest ABI preservation for
> the IPIMI device right now though ? Does it support migration
> at all ?

It does support migration, but the UUID is not migrated, since it
is a property set on the command line.  That means if you
migrated with --uuid and didn't set the IPMI UUID on the command
line for the migration target, it would change behavior.

ABI preservation is probably not important for this particular
feature, but there is a workaround.

-corey

> 
> > 
> > Signed-off-by: Corey Minyard <cminyard@mvista.com>
> > Cc: Cédric Le Goater <clg@kaod.org>
> > Cc: David Gibson <david@gibson.dropbear.id.au>
> > Cc: Michael S. Tsirkin <mst@redhat.com>
> > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > ---
> >  hw/ipmi/ipmi_bmc_sim.c | 22 ++++++++++++++--------
> >  qemu-options.hx        | 10 +++++++---
> >  2 files changed, 21 insertions(+), 11 deletions(-)
> > 
> > diff --git a/hw/ipmi/ipmi_bmc_sim.c b/hw/ipmi/ipmi_bmc_sim.c
> > index 1980536517..007e2c6588 100644
> > --- a/hw/ipmi/ipmi_bmc_sim.c
> > +++ b/hw/ipmi/ipmi_bmc_sim.c
> > @@ -221,7 +221,7 @@ struct IPMIBmcSim {
> >      uint8_t restart_cause;
> >  
> >      uint8_t acpi_power_state[2];
> > -    uint8_t uuid[16];
> > +    QemuUUID uuid;
> >  
> >      IPMISel sel;
> >      IPMISdr sdr;
> > @@ -937,8 +937,19 @@ static void get_device_guid(IPMIBmcSim *ibs,
> >  {
> >      unsigned int i;
> >  
> > +    /* An uninitialized uuid is all zeros, use that to know if it is set. */
> >      for (i = 0; i < 16; i++) {
> > -        rsp_buffer_push(rsp, ibs->uuid[i]);
> > +        if (ibs->uuid.data[i]) {
> > +            goto uuid_set;
> > +        }
> > +    }
> > +    /* No uuid is set, return an error. */
> > +    rsp_buffer_set_error(rsp, IPMI_CC_INVALID_CMD);
> > +    return;
> > +
> > + uuid_set:
> > +    for (i = 0; i < 16; i++) {
> > +        rsp_buffer_push(rsp, ibs->uuid.data[i]);
> >      }
> >  }
> >  
> > @@ -1980,12 +1991,6 @@ static void ipmi_sim_realize(DeviceState *dev, Error **errp)
> >      ibs->acpi_power_state[0] = 0;
> >      ibs->acpi_power_state[1] = 0;
> >  
> > -    if (qemu_uuid_set) {
> > -        memcpy(&ibs->uuid, &qemu_uuid, 16);
> > -    } else {
> > -        memset(&ibs->uuid, 0, 16);
> > -    }
> > -
> >      ipmi_init_sensors_from_sdrs(ibs);
> >      register_cmds(ibs);
> >  
> > @@ -2005,6 +2010,7 @@ static Property ipmi_sim_properties[] = {
> >      DEFINE_PROP_UINT8("fwrev2", IPMIBmcSim, fwrev2, 0),
> >      DEFINE_PROP_UINT32("mfg_id", IPMIBmcSim, mfg_id, 0),
> >      DEFINE_PROP_UINT16("product_id", IPMIBmcSim, product_id, 0),
> > +    DEFINE_PROP_UUID_NODEFAULT("guid", IPMIBmcSim, uuid),
> >      DEFINE_PROP_END_OF_LIST(),
> >  };
> >  
> > diff --git a/qemu-options.hx b/qemu-options.hx
> > index 0d8beb4afd..ec56ab8f6f 100644
> > --- a/qemu-options.hx
> > +++ b/qemu-options.hx
> > @@ -700,7 +700,7 @@ possible drivers and properties, use @code{-device help} and
> >  @code{-device @var{driver},help}.
> >  
> >  Some drivers are:
> > -@item -device ipmi-bmc-sim,id=@var{id}[,slave_addr=@var{val}][,sdrfile=@var{file}][,furareasize=@var{val}][,furdatafile=@var{file}]
> > +@item -device ipmi-bmc-sim,id=@var{id}[,slave_addr=@var{val}][,sdrfile=@var{file}][,furareasize=@var{val}][,furdatafile=@var{file}][,guid=@var{uuid}]
> >  
> >  Add an IPMI BMC.  This is a simulation of a hardware management
> >  interface processor that normally sits on a system.  It provides
> > @@ -713,8 +713,8 @@ controllers.  If you don't know what this means, it is safe to ignore
> >  it.
> >  
> >  @table @option
> > -@item bmc=@var{id}
> > -The BMC to connect to, one of ipmi-bmc-sim or ipmi-bmc-extern above.
> > +@item id=@var{id}
> > +The BMC id for interfaces to use this device.
> >  @item slave_addr=@var{val}
> >  Define slave address to use for the BMC.  The default is 0x20.
> >  @item sdrfile=@var{file}
> > @@ -723,6 +723,10 @@ file containing raw Sensor Data Records (SDR) data. The default is none.
> >  size of a Field Replaceable Unit (FRU) area.  The default is 1024.
> >  @item frudatafile=@var{file}
> >  file containing raw Field Replaceable Unit (FRU) inventory data. The default is none.
> > +@item guid=@var{uuid}
> > +value for the GUID for the BMC, in standard UUID format.  If this is set,
> > +get "Get GUID" command to the BMC will return it.  Otherwise "Get GUID"
> > +will return an error.
> >  @end table
> >  
> >  @item -device ipmi-bmc-extern,id=@var{id},chardev=@var{id}[,slave_addr=@var{val}]
> > -- 
> > 2.17.1
> > 
> > 
> 
> Regards,
> Daniel
> -- 
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

