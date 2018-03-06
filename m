Received: from eggs.gnu.org ([2001:4830:134:3::10]:48563)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1etHl5-00015Z-FY
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 13:56:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1etHl4-0004el-Om
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 13:56:19 -0500
Received: from mail-oi0-x234.google.com ([2607:f8b0:4003:c06::234]:40228)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1etHl4-0004eY-IJ
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 13:56:18 -0500
Received: by mail-oi0-x234.google.com with SMTP id c12so461066oic.7
	for <qemu-devel@nongnu.org>; Tue, 06 Mar 2018 10:56:18 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4e7dd0a0-ca7e-8df7-e966-95e39d34d106@redhat.com>
References: <20180306040154.3669-1-david@gibson.dropbear.id.au>
	<fd62ebf7-3abc-79a2-f269-825b4f8d6598@redhat.com>
	<818fe50b-c3b8-30c5-5452-2009762142c1@ilande.co.uk>
	<4e7dd0a0-ca7e-8df7-e966-95e39d34d106@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 6 Mar 2018 18:55:57 +0000
Message-ID: <CAFEAcA-XdxNMGJP+ci84Amh2KVgpyuOjBB6GaAOZ51u7+BvCnQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/30] ppc-for-2.12 queue 20180306
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org, QEMU Developers <qemu-devel@nongnu.org>

On 6 March 2018 at 17:47, Thomas Huth <thuth@redhat.com> wrote:
> Does the device need to be hot-pluggable or even user_creatable at all?
> It seems like it is also using serial_hds[] directly, so that is a good
> indication that it is *not* user creatable. So maybe the easiest fix is
> to simply set
>
>         dc->user_creatable = false;
>
> in macio_class_init() ?

Yes. As Thomas says, if your device is using serial_hds[] directly
it is not user creatable.

The ideal design here is that the device does not touch serial_hds[] at
all, but instead has qdev properties for char devices, which the board
model code wires up based on serial_hds[]. (In this case you could make
them just be alias properties into the escc object that the macio
device creates.)

Either way I don't think there's any reason for the device to be
user-creatable.

thanks
-- PMM
