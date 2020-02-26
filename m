Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05DF8C4BA24
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 02:25:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8F58208E4
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 02:25:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D/Ti4GHa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8F58208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52850 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j78rx-0006MN-W8
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 21:25:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53413)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <oliver.h.bailey.324@gmail.com>) id 1j769b-0004nh-Pv
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 18:31:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <oliver.h.bailey.324@gmail.com>) id 1j769a-00060k-OA
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 18:31:47 -0500
Received: from mail-il1-x130.google.com ([2607:f8b0:4864:20::130]:40086)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <oliver.h.bailey.324@gmail.com>)
 id 1j769a-0005wu-Dj
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 18:31:46 -0500
Received: by mail-il1-x130.google.com with SMTP id i7so721347ilr.7
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2020 15:31:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=yYRdGdQARoFtmZWKerrKB3iRtrqXY9YJoDGb1LZhCRY=;
 b=D/Ti4GHaMrKWugX/48wrX/XTnCpoAyb1fPUuRhtWIGTh0o3efiBJx/f2TP9RD179Pd
 31w4mx4SIc2NY183P8xriafbK6i8tw/lPyfeYjgJH1mRFiq5NOlSzhLiWc5h2uuh/p+q
 sDxBVprog+A5FQuXa8po+5o0vDobuEPyqkIes0TP7AA2kDMhS+Az6+GtpRi1evTzJgw+
 VVZLstNRUFb81ggd+bKjwzgYMMRFAD8YCPM8qditu4PSI6CZCMOGtqFTH6zJS0QXAKCP
 UEVI+CwAsOaU7oPtTUW/DDCKRPF6tPGdPMOmwbl8dusx8HBRenfagTa5WwJ3oRTih91l
 9MAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=yYRdGdQARoFtmZWKerrKB3iRtrqXY9YJoDGb1LZhCRY=;
 b=D7wL9GKy7ISQ3MPakBljrjNa9nDw9AE6Zke9qUSjjROiOfM9u78EU/El0ts0C5Fb4a
 ecDDEK0olw+a6PEnvxnO4Ho7i2x7FgevYRbzDKECB6CXGboQkVdrdx5PWFNsC2HRM02Y
 YKBgU9yrYYNizqoI6smx70ObKo+BTcT2FqeUDaVMrB0izhoeEVR5J57CuThNlSrzV8tH
 DodH5IO4mPrDCiExITUMu0SLaEdKkN6Jxc/4S+a44Wmz7uDESOMdI09Vip2/bTZLCXpK
 3XfJ9fCPiQHpicSi29Ywb+gOcXC8aGL5tkU/N+IQJRALO9StfJQkbhuK8/n0cbRgPVf3
 w9Ow==
X-Gm-Message-State: APjAAAVPo1eTR0RS9qmNzlqU15eurd5qCOBPFPD8HncHr8G7xJXsjneO
 NMBNdJNdS+vjYXuELymD7ENvqC45QweDH02+rZikcR7zLZM=
X-Google-Smtp-Source: APXvYqxIGLA/x4iOUIkoqnRG+cF1wAierva9aZseuBPfyIJvMoLBu+vOywQqcRym5Lm4r1R/arS1tolSAORA49hNvgY=
X-Received: by 2002:a92:981b:: with SMTP id l27mr1573601ili.118.1582759905007; 
 Wed, 26 Feb 2020 15:31:45 -0800 (PST)
MIME-Version: 1.0
From: Oliver Bailey <oliver.h.bailey.324@gmail.com>
Date: Wed, 26 Feb 2020 17:31:33 -0600
Message-ID: <CAD186yK0oj_cek42XRnvqR9HMz8wGpkSuwXpAwz4ZPOVW1b6DQ@mail.gmail.com>
Subject: qemu-system-x86_64: warning: Unknown X11 keycode mapping '<null>'
To: qemu-devel@nongnu.org
Content-Type: multipart/mixed; boundary="000000000000e80b2a059f83011b"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::130
X-Mailman-Approved-At: Wed, 26 Feb 2020 21:24:46 -0500
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

--000000000000e80b2a059f83011b
Content-Type: multipart/alternative; boundary="000000000000e80b28059f830119"

--000000000000e80b28059f830119
Content-Type: text/plain; charset="UTF-8"

This error occurs when using any version of vncviewer on any platform and
connecting to Debian 10 Buster.

The operating system is: Linux Debian 4.19.0-8-amd64 #1 SMP Debian
4.19.98-1 (2020-01-26) a86_64 GNU/Linux

The X11 Server is: xfce4

The contents of xprop -root are in the attached xprop-root_contents file.

The contents of xdpyinfo are in the attached xdpyinfo_contents file

The issue is that key mappings will only work from the command line of a
terminal when vncviewer is attached to the host tightvnc server. However,
if a recent version of qemu-system-x86_64 is started using UEFI, no
keystrokes are passed on to the UEFI Shell or any menu choice. The guest
just ignores any and all keyboard input.

I hope you can fix this issue as it limits the ability to use QEMU from the
vncviewer. Thos problem does not happen when running qemu from the host
terminal window.

Thank you,
Oliver Bailey

--000000000000e80b28059f830119
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">This error occurs when using any version of vncviewer on a=
ny platform and connecting to Debian 10 Buster.=C2=A0<div><br></div><div>Th=
e operating system is: Linux Debian 4.19.0-8-amd64 #1 SMP Debian 4.19.98-1 =
(2020-01-26) a86_64 GNU/Linux</div><div><br></div><div>The X11 Server is: x=
fce4</div><div><br></div><div>The contents of xprop -root are in the attach=
ed xprop-root_contents file.</div><div><br></div><div>The contents of xdpyi=
nfo are in the=C2=A0attached xdpyinfo_contents file</div><div><br></div><di=
v>The issue is that key mappings will only work from the command line of a =
terminal when vncviewer is attached to the host tightvnc server. However, i=
f a recent version of qemu-system-x86_64 is started using UEFI, no keystrok=
es are passed on to the UEFI Shell or any menu choice. The guest just ignor=
es any and all keyboard input.</div><div><br></div><div>I hope you can fix =
this issue as it limits the ability to use QEMU from the vncviewer. Thos pr=
oblem does not happen when running qemu from the host terminal window.</div=
><div><br></div><div>Thank you,</div><div>Oliver Bailey</div><div><br></div=
><div><br></div><div><br></div></div>

--000000000000e80b28059f830119--

--000000000000e80b2a059f83011b
Content-Type: application/octet-stream; name=xprop-root_contents
Content-Disposition: attachment; filename=xprop-root_contents
Content-Transfer-Encoding: base64
Content-ID: <f_k73y5r3m0>
X-Attachment-Id: f_k73y5r3m0

Q1VUX0JVRkZFUjAoU1RSSU5HKSA9ICJcbj8/Pz8/Pz8/Pz8/Pz8/Pz8/Pz8/Pz8/Pz8/Pz9cbiIK
X05FVF9XTV9VU0VSX1RJTUUoQ0FSRElOQUwpID0gMjAxNzU1NDEzNQpfU0NSRUVOU0FWRVJfU1RB
VFVTKElOVEVHRVIpID0gMCwgMTU4Mjc1ODgzMSwgMApfWFJPT1RQTUFQX0lEKFBJWE1BUCk6IHBp
eG1hcCBpZCAjIDB4MTQwMDA2NQpYRkRFU0tUT1BfSU1BR0VfRklMRV8wKFNUUklORykgPSAiL3Vz
ci9zaGFyZS9pbWFnZXMvZGVza3RvcC1iYXNlL2RlZmF1bHQiCl9ORVRfQ0xJRU5UX0xJU1RfU1RB
Q0tJTkcoV0lORE9XKTogd2luZG93IGlkICMgMHgxNDAwMDA2LCAweDQ4MDAwNjIsIDB4NDQwMDA0
ZCwgMHg0NDAwMDA1LCAweDQ0MDAxMTAsIDB4NDgwMDAwOCwgMHg0ODAwZjZmLCAweDEwMDAwMmIs
IDB4MTAwMDAwNgpfTkVUX0NMSUVOVF9MSVNUKFdJTkRPVyk6IHdpbmRvdyBpZCAjIDB4MTAwMDAw
NiwgMHgxMDAwMDJiLCAweDE0MDAwMDYsIDB4NDgwMDAwOCwgMHg0NDAwMDA1LCAweDQ4MDAwNjIs
IDB4NDgwMGY2ZiwgMHg0NDAwMDRkLCAweDQ0MDAxMTAKX05FVF9BQ1RJVkVfV0lORE9XKFdJTkRP
Vyk6IHdpbmRvdyBpZCAjIDB4NDgwMGY2ZiwgMHgwCl9ORVRfQ1VSUkVOVF9ERVNLVE9QKENBUkRJ
TkFMKSA9IDAKX05FVF9ERVNLVE9QX1ZJRVdQT1JUKENBUkRJTkFMKSA9IDAsIDAKX05FVF9ERVNL
VE9QX0dFT01FVFJZKENBUkRJTkFMKSA9IDgwMCwgNjAwCl9ORVRfU1VQUE9SVElOR19XTV9DSEVD
SyhXSU5ET1cpOiB3aW5kb3cgaWQgIyAweDFjMDAwMTcKX05FVF9TVVBQT1JURUQoQVRPTSkgPSBf
TkVUX0FDVElWRV9XSU5ET1csIF9ORVRfQ0xJRU5UX0xJU1QsIF9ORVRfQ0xJRU5UX0xJU1RfU1RB
Q0tJTkcsIF9ORVRfQ0xPU0VfV0lORE9XLCBfTkVUX0NVUlJFTlRfREVTS1RPUCwgX05FVF9ERVNL
VE9QX0dFT01FVFJZLCBfTkVUX0RFU0tUT1BfTEFZT1VULCBfTkVUX0RFU0tUT1BfTkFNRVMsIF9O
RVRfREVTS1RPUF9WSUVXUE9SVCwgX05FVF9GUkFNRV9FWFRFTlRTLCBfTkVUX01PVkVSRVNJWkVf
V0lORE9XLCBfTkVUX05VTUJFUl9PRl9ERVNLVE9QUywgX05FVF9SRVFVRVNUX0ZSQU1FX0VYVEVO
VFMsIF9ORVRfU0hPV0lOR19ERVNLVE9QLCBfTkVUX1NVUFBPUlRFRCwgX05FVF9TVVBQT1JUSU5H
X1dNX0NIRUNLLCBfTkVUX1NZU1RFTV9UUkFZX09QQ09ERSwgX05FVF9XTV9BQ1RJT05fQUJPVkUs
IF9ORVRfV01fQUNUSU9OX0JFTE9XLCBfTkVUX1dNX0FDVElPTl9DSEFOR0VfREVTS1RPUCwgX05F
VF9XTV9BQ1RJT05fQ0xPU0UsIF9ORVRfV01fQUNUSU9OX0ZVTExTQ1JFRU4sIF9ORVRfV01fQUNU
SU9OX01BWElNSVpFX0hPUlosIF9ORVRfV01fQUNUSU9OX01BWElNSVpFX1ZFUlQsIF9ORVRfV01f
QUNUSU9OX01JTklNSVpFLCBfTkVUX1dNX0FDVElPTl9NT1ZFLCBfTkVUX1dNX0FDVElPTl9SRVNJ
WkUsIF9ORVRfV01fQUNUSU9OX1NIQURFLCBfTkVUX1dNX0FDVElPTl9TVElDSywgX05FVF9XTV9B
TExPV0VEX0FDVElPTlMsIF9ORVRfV01fQ09OVEVYVF9IRUxQLCBfTkVUX1dNX0RFU0tUT1AsIF9O
RVRfV01fRlVMTFNDUkVFTl9NT05JVE9SUywgX05FVF9XTV9JQ09OLCBfTkVUX1dNX0lDT05fR0VP
TUVUUlksIF9ORVRfV01fSUNPTl9OQU1FLCBfTkVUX1dNX01PVkVSRVNJWkUsIF9ORVRfV01fTkFN
RSwgX05FVF9XTV9QSUQsIF9ORVRfV01fUElORywgX05FVF9XTV9TVEFURSwgX05FVF9XTV9TVEFU
RV9BQk9WRSwgX05FVF9XTV9TVEFURV9CRUxPVywgX05FVF9XTV9TVEFURV9ERU1BTkRTX0FUVEVO
VElPTiwgX05FVF9XTV9TVEFURV9GT0NVU0VELCBfTkVUX1dNX1NUQVRFX0ZVTExTQ1JFRU4sIF9O
RVRfV01fU1RBVEVfSElEREVOLCBfTkVUX1dNX1NUQVRFX01BWElNSVpFRF9IT1JaLCBfTkVUX1dN
X1NUQVRFX01BWElNSVpFRF9WRVJULCBfTkVUX1dNX1NUQVRFX01PREFMLCBfTkVUX1dNX1NUQVRF
X1NIQURFRCwgX05FVF9XTV9TVEFURV9TS0lQX1BBR0VSLCBfTkVUX1dNX1NUQVRFX1NLSVBfVEFT
S0JBUiwgX05FVF9XTV9TVEFURV9TVElDS1ksIF9ORVRfV01fU1RSVVQsIF9ORVRfV01fU1RSVVRf
UEFSVElBTCwgX05FVF9XTV9TWU5DX1JFUVVFU1QsIF9ORVRfV01fU1lOQ19SRVFVRVNUX0NPVU5U
RVIsIF9ORVRfV01fVVNFUl9USU1FLCBfTkVUX1dNX1VTRVJfVElNRV9XSU5ET1csIF9ORVRfV01f
V0lORE9XX09QQUNJVFksIF9ORVRfV01fV0lORE9XX09QQUNJVFlfTE9DS0VELCBfTkVUX1dNX1dJ
TkRPV19UWVBFLCBfTkVUX1dNX1dJTkRPV19UWVBFX0RFU0tUT1AsIF9ORVRfV01fV0lORE9XX1RZ
UEVfRElBTE9HLCBfTkVUX1dNX1dJTkRPV19UWVBFX0RPQ0ssIF9ORVRfV01fV0lORE9XX1RZUEVf
TUVOVSwgX05FVF9XTV9XSU5ET1dfVFlQRV9OT1JNQUwsIF9ORVRfV01fV0lORE9XX1RZUEVfU1BM
QVNILCBfTkVUX1dNX1dJTkRPV19UWVBFX1RPT0xCQVIsIF9ORVRfV01fV0lORE9XX1RZUEVfVVRJ
TElUWSwgX05FVF9XT1JLQVJFQSwgX0dUS19GUkFNRV9FWFRFTlRTLCBfR1RLX0hJREVfVElUTEVC
QVJfV0hFTl9NQVhJTUlaRUQsIF9HVEtfU0hPV19XSU5ET1dfTUVOVSwgX05FVF9TVEFSVFVQX0lE
Cl9ORVRfREVTS1RPUF9OQU1FUyhVVEY4X1NUUklORykgPSAiV29ya3NwYWNlIDEiLCAiV29ya3Nw
YWNlIDIiLCAiV29ya3NwYWNlIDMiLCAiV29ya3NwYWNlIDQiLCAiIgpfTkVUX1dPUktBUkVBKENB
UkRJTkFMKSA9IDAsIDMxLCA4MDAsIDUyMCwgMCwgMzEsIDgwMCwgNTIwLCAwLCAzMSwgODAwLCA1
MjAsIDAsIDMxLCA4MDAsIDUyMApfTkVUX05VTUJFUl9PRl9ERVNLVE9QUyhDQVJESU5BTCkgPSA0
Cl9ORVRfREVTS1RPUF9MQVlPVVQoQ0FSRElOQUwpID0gMCwgMCwgMSwgMApOQVVUSUxVU19ERVNL
VE9QX1dJTkRPV19JRChXSU5ET1cpOiB3aW5kb3cgaWQgIyAweDE0MDAwMDYKWEZDRV9ERVNLVE9Q
X1dJTkRPVyhXSU5ET1cpOiB3aW5kb3cgaWQgIyAweDE0MDAwMDYKWEtMQVZJRVJfQUxMT1dfU0VD
T05EQVJZKElOVEVHRVIpID0gMApBVF9TUElfQlVTKFNUUklORykgPSAidW5peDphYnN0cmFjdD0v
dG1wL2RidXMtaTdHRHRMcFFLbSxndWlkPTkwYTlmODBjZjAyMDdhY2NiY2ZhOTgyZTVlNGVmM2Yx
IgpSRVNPVVJDRV9NQU5BR0VSKFNUUklORykgPSAiXG5YZnQuaGludHN0eWxlOlx0aGludG5vbmVc
blhmdC5yZ2JhOlx0bm9uZVxuWGN1cnNvci50aGVtZTpcdFxuWGN1cnNvci5zaXplOlx0MFxuWGN1
cnNvci50aGVtZV9jb3JlOlx0MVxuIgo=
--000000000000e80b2a059f83011b
Content-Type: application/octet-stream; name=xdpyinfo_contents
Content-Disposition: attachment; filename=xdpyinfo_contents
Content-Transfer-Encoding: base64
Content-ID: <f_k73y6z2p1>
X-Attachment-Id: f_k73y6z2p1

bmFtZSBvZiBkaXNwbGF5OiAgICA6MS4wCnZlcnNpb24gbnVtYmVyOiAgICAxMS4wCnZlbmRvciBz
dHJpbmc6ICAgIEFUJlQgTGFib3JhdG9yaWVzIENhbWJyaWRnZQp2ZW5kb3IgcmVsZWFzZSBudW1i
ZXI6ICAgIDMzMzIKbWF4aW11bSByZXF1ZXN0IHNpemU6ICA0MTk0MzAwIGJ5dGVzCm1vdGlvbiBi
dWZmZXIgc2l6ZTogIDI1NgpiaXRtYXAgdW5pdCwgYml0IG9yZGVyLCBwYWRkaW5nOiAgICAzMiwg
TFNCRmlyc3QsIDMyCmltYWdlIGJ5dGUgb3JkZXI6ICAgIExTQkZpcnN0Cm51bWJlciBvZiBzdXBw
b3J0ZWQgcGl4bWFwIGZvcm1hdHM6ICAgIDIKc3VwcG9ydGVkIHBpeG1hcCBmb3JtYXRzOgogICAg
ZGVwdGggMSwgYml0c19wZXJfcGl4ZWwgMSwgc2NhbmxpbmVfcGFkIDMyCiAgICBkZXB0aCAyNCwg
Yml0c19wZXJfcGl4ZWwgMzIsIHNjYW5saW5lX3BhZCAzMgprZXljb2RlIHJhbmdlOiAgICBtaW5p
bXVtIDgsIG1heGltdW0gMjU1CmZvY3VzOiAgd2luZG93IDB4NDgwMGY3MCwgcmV2ZXJ0IHRvIFBh
cmVudApudW1iZXIgb2YgZXh0ZW5zaW9uczogICAgNwogICAgQklHLVJFUVVFU1RTCiAgICBNSVQt
U0hNCiAgICBNSVQtU1VORFJZLU5PTlNUQU5EQVJECiAgICBTSEFQRQogICAgU1lOQwogICAgWEMt
TUlTQwogICAgWFRFU1QKZGVmYXVsdCBzY3JlZW4gbnVtYmVyOiAgICAwCm51bWJlciBvZiBzY3Jl
ZW5zOiAgICAxCgpzY3JlZW4gIzA6CiAgZGltZW5zaW9uczogICAgODAweDYwMCBwaXhlbHMgKDI3
MXgyMDMgbWlsbGltZXRlcnMpCiAgcmVzb2x1dGlvbjogICAgNzV4NzUgZG90cyBwZXIgaW5jaAog
IGRlcHRocyAoMSk6ICAgIDI0CiAgcm9vdCB3aW5kb3cgaWQ6ICAgIDB4MjUKICBkZXB0aCBvZiBy
b290IHdpbmRvdzogICAgMjQgcGxhbmVzCiAgbnVtYmVyIG9mIGNvbG9ybWFwczogICAgbWluaW11
bSAxLCBtYXhpbXVtIDEKICBkZWZhdWx0IGNvbG9ybWFwOiAgICAweDIxCiAgZGVmYXVsdCBudW1i
ZXIgb2YgY29sb3JtYXAgY2VsbHM6ICAgIDI1NgogIHByZWFsbG9jYXRlZCBwaXhlbHM6ICAgIGJs
YWNrIDAsIHdoaXRlIDE2Nzc3MjE1CiAgb3B0aW9uczogICAgYmFja2luZy1zdG9yZSBZRVMsIHNh
dmUtdW5kZXJzIFlFUwogIGxhcmdlc3QgY3Vyc29yOiAgICA4MDB4NjAwCiAgY3VycmVudCBpbnB1
dCBldmVudCBtYXNrOiAgICAweGZhODAwZgogICAgS2V5UHJlc3NNYXNrICAgICAgICAgICAgIEtl
eVJlbGVhc2VNYXNrICAgICAgICAgICBCdXR0b25QcmVzc01hc2sgICAgICAgICAgCiAgICBCdXR0
b25SZWxlYXNlTWFzayAgICAgICAgRXhwb3N1cmVNYXNrICAgICAgICAgICAgIFN0cnVjdHVyZU5v
dGlmeU1hc2sgICAgICAKICAgIFN1YnN0cnVjdHVyZU5vdGlmeU1hc2sgICBTdWJzdHJ1Y3R1cmVS
ZWRpcmVjdE1hc2sgRm9jdXNDaGFuZ2VNYXNrICAgICAgICAgIAogICAgUHJvcGVydHlDaGFuZ2VN
YXNrICAgICAgIENvbG9ybWFwQ2hhbmdlTWFzayAgICAgICAKICBudW1iZXIgb2YgdmlzdWFsczog
ICAgMQogIGRlZmF1bHQgdmlzdWFsIGlkOiAgMHgyMgogIHZpc3VhbDoKICAgIHZpc3VhbCBpZDog
ICAgMHgyMgogICAgY2xhc3M6ICAgIFRydWVDb2xvcgogICAgZGVwdGg6ICAgIDI0IHBsYW5lcwog
ICAgYXZhaWxhYmxlIGNvbG9ybWFwIGVudHJpZXM6ICAgIDI1NiBwZXIgc3ViZmllbGQKICAgIHJl
ZCwgZ3JlZW4sIGJsdWUgbWFza3M6ICAgIDB4ZmYwMDAwLCAweGZmMDAsIDB4ZmYKICAgIHNpZ25p
ZmljYW50IGJpdHMgaW4gY29sb3Igc3BlY2lmaWNhdGlvbjogICAgOCBiaXRzCg==
--000000000000e80b2a059f83011b--

