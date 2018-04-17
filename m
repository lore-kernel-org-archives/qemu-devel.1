Received: from eggs.gnu.org ([2001:4830:134:3::10]:55001)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikhilbalachandra.inbox@gmail.com>)
	id 1f8IDf-00064S-7H
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 00:27:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikhilbalachandra.inbox@gmail.com>)
	id 1f8IDd-0003pv-RK
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 00:27:51 -0400
Received: from mail-lf0-x22e.google.com ([2a00:1450:4010:c07::22e]:35533)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <nikhilbalachandra.inbox@gmail.com>)
	id 1f8IDd-0003fX-FF
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 00:27:49 -0400
Received: by mail-lf0-x22e.google.com with SMTP id r125-v6so8536671lfe.2
	for <qemu-devel@nongnu.org>; Mon, 16 Apr 2018 21:27:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180416073100.GA28904@stefanha-x1.localdomain>
References: <20180406194205.9872-1-nikhilbalachandra.inbox@gmail.com>
	<20180416073100.GA28904@stefanha-x1.localdomain>
From: Nikhil Balachandra <nikhilbalachandra.inbox@gmail.com>
Date: Tue, 17 Apr 2018 09:57:46 +0530
Message-ID: <CAAGXMmLL2TBmNDqtVjp7y56WT6NadmX8X4HMBhXaWX6jJnirDg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 1/1] Make qemu-bridge-helper work in macOS
 and FreeBSD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org

Hi Stefan,

Thanks for the review. I'll be sending v2 version of this patch in next 3-4
days with the following changes.

1) New scripts/update-xnu-headers.sh script to import if_bridgevar.h[4]
into include/standard-headers/xnu directory.
    @qemu-devel - Please let me know if there is a better approach.
2) Fix broken vnet hdr in this patch.
3) Having minimal code in qemu-bridge-helper.c to open tap device instead
of using tap_open().

[4] - macOS if_bridgevar.h header file has APSL and BSD license.


On Mon, Apr 16, 2018 at 1:01 PM, Stefan Hajnoczi <stefanha@gmail.com> wrote:

> On Sat, Apr 07, 2018 at 01:12:05AM +0530, Nikhil Balachandra wrote:
> > Eventhough macOS does not ship with the if_bridgevar.h header file[2],
> > I expect the API to remain stable as this header file is similar to what
> > is found in other BSDs. If this patch is decided to be included in the
> > qemu, can experienced qemu developers please tell me how to go about
> > having this header file in the include path such that it does not require
> > manually downloading and copying the file[3]?
>
> QEMU ships Linux headers.  They are synced using this script:
> scripts/update-linux-headers.sh
>
> If the macOS header is appropriately licensed, it could be kept under
> include/standard-headers/ alongside the other third-party headers that
> QEMU ships.
>
> > @@ -310,30 +374,18 @@ int main(int argc, char **argv)
> >          goto cleanup;
> >      }
> >
> > +
> >      /* open the tap device */
> > -    fd = open("/dev/net/tun", O_RDWR);
> > +    memset(&iface, '\0', sizeof(char) * IFNAMSIZ);
> > +    int vnet_supported = has_vnet_hdr(fd);
>
> fd is always -1 here, so this patch breaks vnet hdr?
>
> > +    Error *err = NULL;
> > +    fd = tap_open(&iface[0], sizeof(iface), &vnet_supported, use_vnet,
> 0, &err);
>
> tap_open() was not written with setuid programs in mind.  I think this
> is a case where code duplication is justified.
>
> It's safer to have the minimal code to open the tap device rather than
> calling into QEMU code which may not realize it is running setuid.
>
