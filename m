Return-Path: <SRS0=Zx28=6B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EABFC2D0EF
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 18:37:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17BDC20780
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 18:37:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="cJKLlzqo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17BDC20780
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPVru-0008JB-8O
	for qemu-devel@archiver.kernel.org; Fri, 17 Apr 2020 14:37:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42209)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <osandov@osandov.com>) id 1jPVqT-0007T2-J5
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 14:36:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <osandov@osandov.com>) id 1jPVqR-000151-42
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 14:36:09 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:45752)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <osandov@osandov.com>) id 1jPVqQ-00012d-Ob
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 14:36:07 -0400
Received: by mail-pf1-x442.google.com with SMTP id w65so1437249pfc.12
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2020 11:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=osandov-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=Hzvj7OOYXOhPIvsUeCGihYX8zmn28YGY+um7T06891I=;
 b=cJKLlzqoZvjBuZD4xd6rQkvcPOk4WPVU+Wrlkp2xet4/vp5Hu/OGYfwO/vbPT6wieB
 rnUrV/1iOohIhFYKHdE6vALCkT4UjhSmZObmbYoEZ/Chsup+ohKHaEIV974tSC7BfBJD
 swSKrYpCq5B9Ffu3obdQCYPphyiomcYjhHimZuh9EZW5WPmkIlF+vthMHADbTksppaKX
 T/6rhyTqfCs/BkgMJrS2GM8LohC8NKvhZqGtlLVu+RK95PpMGASR4MkNky0ej4yJxVEw
 xCLRBzyRLTA5biJE9JclZtonUZQsSEIVnfgmZkyf/KseBc+u2XWlRGdqwYTXVWO9duYx
 cALQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Hzvj7OOYXOhPIvsUeCGihYX8zmn28YGY+um7T06891I=;
 b=TDLd1DsyhXnTSF0XGGIFN1PPoLjuV/wVefbpJ0Y7sIx+ggsWMyyHj/msaYlaayYs27
 Hw9gEYFShOYQSNSmNkb71OqHSYI3nUZW52sP5RGMpuaIJWCm5bbeyiHS4xOzIbn4fbD5
 W3AfmUOTdMuX+24IQvy+lGi44uubA8ro/mAaAsYQuEEKLILTTQ1QcwWoUuQrOmg5GSGH
 6sOqblo+4rjMsf7U/byNU6OeNTDbciys/uxddnNp+nAymFZHP4Bd1scd3r9fKEGWJSnl
 T7k23B/ILU0K31yjtGh1rliqGrNU7Y1T8hzbgFO/kgrwA44IAPruPzeNocl4ZHrApAGN
 2R9w==
X-Gm-Message-State: AGi0PuYZnJcBy+jQ46iH9mNO73nrRy80xA7bvZmQD3LJHqoNY5nur0C9
 b/tHon4bXNrosQrB/f2hvyygdFTE1Hk=
X-Google-Smtp-Source: APiQypK+wdAUuWnlNh+Ay2bjSvRtEuNozJOb7Qq8kv9CznNZUIk7Ak0EHWbKjAR+apQv8yp/KEAPKg==
X-Received: by 2002:a63:1506:: with SMTP id v6mr4513712pgl.365.1587148565193; 
 Fri, 17 Apr 2020 11:36:05 -0700 (PDT)
Received: from vader ([2620:10d:c090:400::5:82d8])
 by smtp.gmail.com with ESMTPSA id a18sm6236745pjh.25.2020.04.17.11.36.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2020 11:36:04 -0700 (PDT)
Date: Fri, 17 Apr 2020 11:36:01 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Subject: Re: [PATCH] 9pfs: local: ignore O_NOATIME if we don't have permissions
Message-ID: <20200417183601.GA719237@vader>
References: <1e65cffe9778857735e7ae6066d6f0df0b0e2db3.1586997767.git.osandov@fb.com>
 <2496702.lrWaslOkEp@silver> <20200416184711.GB696015@vader>
 <1939315.5ePf2Jtb4B@silver>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1939315.5ePf2Jtb4B@silver>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
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
Cc: qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Apr 17, 2020 at 12:45:36PM +0200, Christian Schoenebeck wrote:
> On Donnerstag, 16. April 2020 20:47:11 CEST Omar Sandoval wrote:
> > > > Luckily, O_NOATIME is effectively a hint, and is often ignored by, e.g.,
> > > > network filesystems. open(2) notes that O_NOATIME "may not be effective
> > > > on all filesystems. One example is NFS, where the server maintains the
> > > > access time." This means that we can honor it when possible but fall
> > > > back to ignoring it.
> > > 
> > > I am not sure whether NFS would simply silently ignore O_NOATIME i.e.
> > > without returning EPERM. I don't read it that way.
> > 
> > As far as I can tell, the NFS protocol has nothing equivalent to
> > O_NOATIME and thus can't honor it. Feel free to test it:
> 
> I did not doubt that NFS does not support O_NOATIME, what I said was that I 
> thought using O_NOATIME on NFS would return EPERM, but ...
> 
> >   # mount -t nfs -o vers=4,rw 10.0.2.2:/ /mnt
> >   # echo foo > /mnt/foo
> >   # touch -d "1 hour ago" /mnt/foo
> >   # stat /mnt/foo | grep 'Access: [0-9]'
> >   Access: 2020-04-16 10:43:36.838952593 -0700
> >   # # Drop caches so we have to go to the NFS server.
> >   # echo 3 > /proc/sys/vm/drop_caches
> >   # strace -e openat dd if=/mnt/foo of=/dev/null iflag=noatime |& grep
> > /mnt/foo openat(AT_FDCWD, "/mnt/foo", O_RDONLY|O_NOATIME) = 3
> >   # stat /mnt/foo | grep 'Access: [0-9]'
> >   Access: 2020-04-16 11:43:36.906462928 -0700
> 
> ... I tried this as well, and you are right, O_NOATIME is indeed simply 
> *silently* dropped/ignored by NFS (i.e. without raising any error).
> 
> > > It would certainly fix the problem in your use case. But it would also
> > > unmask O_NOATIME for all other ones (i.e. regular users on guest).
> > 
> > The guest kernel will still check whether processes on the guest have
> > permission to use O_NOATIME. This only changes the behavior when the
> > guest kernel believes that the process has permission even though the
> > host QEMU process doesn't.
> 
> Good point!
> 
> > > I mean I understand your point, but I also have to take other use cases
> > > into account which might expect to receive EPERM if O_NOATIME cannot be
> > > granted.
> > If you'd still like to preserve this behavior, would it be acceptable to
> > make this a QEMU option? Maybe something like "-virtfs
> > honor_noatime=no": the default would be "yes", which is the current
> > behavior, and "no" would always mask out NOATIME.
> 
> That was my initial tendency yesterday, but your arguments now convinced me 
> that the implied re-run, in the way your provided patch already does, is in 
> this particular case the better choice.
> 
> Making that a configurable option would render this issue unnecessarily 
> complicated and probably even contra productive for other users which might 
> stumble over the same issue.
> 
> Just do me a favour: you already thoroughly explained the issue in the commit 
> log, that's good, but please also add a short comment in code why the rerun is 
> required, because it is not obvious by just reading the code. Finding that 
> info from git log becomes tedious as soon as code is refactored there.
> 
> Aside of the missing comment in code:
> 
> Acked-by: Christian Schoenebeck <qemu_oss@crudebyte.com>

Thank you! I'll add the comment and resend.

