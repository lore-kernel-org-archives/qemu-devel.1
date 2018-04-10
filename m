Received: from eggs.gnu.org ([2001:4830:134:3::10]:57448)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1f5pNr-0006mc-Uk
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 05:16:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1f5pNp-0001Gd-AI
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 05:16:11 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57692 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1f5pNp-0001GU-5P
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 05:16:09 -0400
References: <20180407000117.25640-1-lersek@redhat.com>
	<979bd720-cdb3-6468-1fbd-e8ec1c6c6c8d@redhat.com>
	<8ddd0a2f-b9b1-08c0-0f4d-62e7aea7e96a@redhat.com>
	<20180410062754.eohou7i7chf6w65j@sirius.home.kraxel.org>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <dc439111-4161-96e6-5b45-4dcee886427d@redhat.com>
Date: Tue, 10 Apr 2018 11:16:01 +0200
MIME-Version: 1.0
In-Reply-To: <20180410062754.eohou7i7chf6w65j@sirius.home.kraxel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu RFC] qapi: add "firmware.json"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, libvir-list@redhat.com, "Daniel P. Berrange" <berrange@redhat.com>, Alexander Graf <agraf@suse.de>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, David Gibson <dgibson@redhat.com>, Eric Blake <eblake@redhat.com>, Gary Ching-Pang Lin <glin@suse.com>, Kashyap Chamarthy <kchamart@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Michal Privoznik <mprivozn@redhat.com>, Peter Krempa <pkrempa@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

On 04/10/18 08:27, Gerd Hoffmann wrote:
>   Hi,
> 
>> - I considered adding wildcards (say, blacklist "all" i440fx machtypes,
>> present and future, for SMM-requiring OVMF builds), but then you get
>> into version sorting and similar mess. I considered fnmatch() --
>> basically simple ? and * wildcards -- but that's not expressive enough.
> 
> I'd suggest whitelist with wildcards.  So the smm builds would get
> "pc-q35-*".
> 
> libvirt knows about aliases, so it should be able to handle the "q35"
> shortcut like "pc-q35-${latest}".
> 
> Or do you see another issue?

Well, one issue I see is version sorting; I should say "Q35 but no
earlier than 2.4", and lexicographically, "2.11" sorts before "2.4".

Anyway (also asking for Thomas's input here): if we run with your idea
to refer to exact mapping methods / firmware *implementation* types that
we know libvirt implements / supports as a "white box", do we still deem
machine type identification necessary? Because, libvirt already knows
(for example) that "ovmf_smm" requires pc-q35-2.4 or later. So we just
have to make a *reference* to that knowledge in the JSON file.

And, really, this seems to reinforce my point that the schema should
live in the libvirtd tree, not in the QEMU tree. In that case, perhaps
it would be a better fit to work with an XSD, and firmware packages
should install XML files? Personally I'm a lot more attracted to
XML/XSD; I think the tooling is better too. I just don't see how QEMU is
involved.

Opinions please :)
Thanks!
Laszlo
