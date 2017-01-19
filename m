Received: from eggs.gnu.org ([2001:4830:134:3::10]:46310)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1cUBgb-00046X-OK
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 07:19:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1cUBgY-0005jv-Ke
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 07:19:25 -0500
Received: from [59.151.112.132] (port=58205 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1cUBgY-0005he-4t
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 07:19:22 -0500
References: <1484633936-25344-1-git-send-email-caoj.fnst@cn.fujitsu.com>
	<1484633936-25344-5-git-send-email-caoj.fnst@cn.fujitsu.com>
	<587DBEBE.4070409@cn.fujitsu.com>
	<20170117175708-mutt-send-email-mst@kernel.org>
	<587F0B3F.1040300@cn.fujitsu.com>
	<20170118171932-mutt-send-email-mst@kernel.org>
From: Cao jin <caoj.fnst@cn.fujitsu.com>
Message-ID: <5880B026.8060605@cn.fujitsu.com>
Date: Thu, 19 Jan 2017 20:25:10 +0800
MIME-Version: 1.0
In-Reply-To: <20170118171932-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v9 04/11] msix: check msix_init's return
 value
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>



On 01/18/2017 11:21 PM, Michael S. Tsirkin wrote:
> On Wed, Jan 18, 2017 at 02:29:19PM +0800, Cao jin wrote:
>>
>>
>> On 01/18/2017 12:01 AM, Michael S. Tsirkin wrote:
>>> On Tue, Jan 17, 2017 at 02:50:38PM +0800, Cao jin wrote:
>>>> forget to cc maintainers in this new patch
>>>>
>>>> On 01/17/2017 02:18 PM, Cao jin wrote:
>>>>> Doesn't do it for megasas & hcd-xhci, later patches will fix them.
>>>>>
>>>>> Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
>>>
>>> I don't like this one, frankly. That's a bunch of code duplication.
>>
>> Yes, code duplication, seems inevitable if move the asserts into a
>> separate patch.
>>
>>> I suspect vfio is the only one who might reasonably get EINVAL here.
>>> So how about e.g. msix_validate_and_init that doesn't assert and use that
>>> from vfio, then switch msix_init to assert instead?
>>>
>>
>> Not sure if I get your idea. Do you mean: do param check via assert in
>> msix_init(), so that no need check its returned error outside, and
>> introduce new api msix_validate_and_init(same content as msix_init,
>> except param check) dedicated to vfio?
> 
> Something like this.
> 
>> If I understand you right, the way we do param check for msi_init[*] &
>> msix_init will be inconsistent.
> 
> Right, we should consolidate these for msi too.
> 
> 

I got confused: for msi_init, convert assert to return -errno is a
choice from a long discussion:
http://lists.nongnu.org/archive/html/qemu-devel/2016-09/msg08215.html

then now we will revert again? And IIRC, I did use assert in msix_init
to do sanity test, and revert as suggest. And this is the way we have
done for msi_init: assert the return error outside.  And if it need to
be modified as your suggestion, I see lots of place need to be taken
care, does that worth the trouble?

I see there is a simpler way helping us: drop this one from the
patchset, at least there is no regression, just a few devices doesn't
assert the return error while other(megasas, hcd-xhci) does.  What would
you say?
-- 
Sincerely,
Cao jin
