Received: from eggs.gnu.org ([2001:4830:134:3::10]:59115)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1f9RvO-0004bi-6s
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 05:01:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1f9RvI-0006Nn-Ic
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 05:01:46 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40220 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1f9RvI-0006NJ-Cr
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 05:01:40 -0400
References: <20180417224054.26363-1-lersek@redhat.com>
	<20180418060243.iafg4wj5gwsruop5@sirius.home.kraxel.org>
	<b9c7d767-39c4-065f-f487-34c0c682bd85@redhat.com>
	<20180419100900.7b66fde0@umbus.fritz.box>
	<d032dfe2-bfab-5a12-c867-a5229f303f5f@redhat.com>
	<20180420110301.1734899d@umbus.fritz.box>
	<57df20fb-4a5b-7219-b364-29444ae86461@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <40fc25bc-8fa6-1a62-579d-95da029219ec@redhat.com>
Date: Fri, 20 Apr 2018 11:01:28 +0200
MIME-Version: 1.0
In-Reply-To: <57df20fb-4a5b-7219-b364-29444ae86461@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu RFC v2] qapi: add "firmware.json"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, David Gibson <dgibson@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org, libvir-list@redhat.com, "Daniel P. Berrange" <berrange@redhat.com>, Alexander Graf <agraf@suse.de>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Eric Blake <eblake@redhat.com>, Gary Ching-Pang Lin <glin@suse.com>, Kashyap Chamarthy <kchamart@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Michal Privoznik <mprivozn@redhat.com>, Peter Krempa <pkrempa@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>

On 04/20/18 10:47, Paolo Bonzini wrote:
> On 20/04/2018 03:03, David Gibson wrote:
>>> This also implies I shouldn't add "openbios" separately, which was
>>> suggested earlier by Gerd -- according to
>>> <https://en.wikipedia.org/wiki/OpenBIOS>, OpenBIOS is another
>>> implementation of OFW.
>>
>> Right.  Although I think OpenBIOS and SLOF support a disjoint set of
>> machines.  Openhackware which is (was?) used on some machines is yet
>> another (very partial) openfirmware implementation.
> 
> We can:
> 
> 1a) replace the architecture field with an ABI field (seems wrong to me)
> 
> 1b) add an "ABI" field (containing e.g. prep, spapr, etc.) to complement
> the architecture field
> 
> 2) we include directly a glob pattern for the QEMU machine types (also
> seems wrong).

Using globs in machine types was what Gerd and Daniel agreed upon, and I
was planning to do for v3. :(

> 3) just like we effectively moved the guest ABI to the features field,

No, we didn't -- while it's true that a single firmware image can
provide multiple guest ABIs, the implementation quality of those guest
ABIs is not identical, and there is a preference order between them. The
latest idea was to keep the @type field, but turn it into an ordered
list of enum constants. Whichever constant is near the top is the more
preferred ABI, and mgmt tools, when looking for "the" type of the
firware, would consider the topmost (first) element.

> we split the features into host-features and guest-features, and the
> host ABI (prep, spapr, etc.; but also OVMF's SMM requirement fits here
> for example) moves into host-features.  Again, just like 1a/1b, this can
> be replace or complement the architecture field, and I think I'd prefer
> the latter

I'd prefer if we could mostly stick with the structure of the schema as
seen in RFCv2 -- all the feedback until now implies that's possible,
with minor tweaks. Let me post an RFCv3 soon, so that we have a more
up-to-date basis for the discussion. (I've been waiting for some of the
architecture (emulation target) technicalities to clear up, but I guess
I had better postpone that now, because I see the discussion diverging.)

Thanks!
Laszlo
