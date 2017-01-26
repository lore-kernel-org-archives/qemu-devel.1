Received: from eggs.gnu.org ([2001:4830:134:3::10]:40606)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cWrUB-00050I-Kf
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 16:21:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cWrU7-0006S2-1X
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 16:21:39 -0500
Received: from mail-vk0-x231.google.com ([2607:f8b0:400c:c05::231]:34710)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cWrU6-0006Rj-ST
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 16:21:34 -0500
Received: by mail-vk0-x231.google.com with SMTP id r136so163731457vke.1
	for <qemu-devel@nongnu.org>; Thu, 26 Jan 2017 13:21:34 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA__2S3jTKEFy3Ue=Vvw+tuE1Du573PQp-VYOa6jBRpWCw@mail.gmail.com>
References: <20170124164253.jiva4zvk6fxewtsk@dhcp-3-221.uk.xensource.com>
	<alpine.DEB.2.10.1701241315310.10192@sstabellini-ThinkPad-X260>
	<alpine.DEB.2.10.1701241326560.10192@sstabellini-ThinkPad-X260>
	<20170125110529.5rgu7xrh3gkoadog@dhcp-3-221.uk.xensource.com>
	<20170126154509.rxi5sy4bcob2ioen@dhcp-3-221.uk.xensource.com>
	<alpine.DEB.2.10.1701261017370.2884@sstabellini-ThinkPad-X260>
	<CAFEAcA__2S3jTKEFy3Ue=Vvw+tuE1Du573PQp-VYOa6jBRpWCw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 26 Jan 2017 21:21:13 +0000
Message-ID: <CAFEAcA_1cEbnBg9KA35y0OTk_Hw+bng2Guof84WuKfRWhx1A6g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [Xen-devel] Commit 3a6c9 breaks QEMU on FreeBSD/Xen
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Stabellini <sstabellini@kernel.org>
Cc: =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>, Juergen Gross <jgross@suse.com>, xen-devel@lists.xenproject.org, QEMU Developers <qemu-devel@nongnu.org>

On 26 January 2017 at 20:47, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 26 January 2017 at 19:36, Stefano Stabellini <sstabellini@kernel.org> wrote:
>> It should be just a matter of replacing qdev_init_nofail with something
>> that can fail. I couldn't find a regular qdev_init that can return
>> error, so maybe we would need to add it.
>
> That's just
>     object_property_set_bool(OBJECT(whatever), true, "realized", &err);
>
> ie "please realize the device".

(PS watch out for ownership refcounting issues depending on what
you did with parenting the device: you likely want to object_unparent()
and then object_unref() the thing in the error-exit path. See
qdev_device_add() for some example code, maybe.)

-- PMM
