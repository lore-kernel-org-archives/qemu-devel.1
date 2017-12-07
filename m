Received: from eggs.gnu.org ([2001:4830:134:3::10]:43938)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1eN0vz-0003TE-EG
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 13:30:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1eN0vv-0001TL-FP
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 13:30:11 -0500
Received: from mail-vk0-f43.google.com ([209.85.213.43]:40637)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <lprosek@redhat.com>) id 1eN0vv-0001Rc-B0
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 13:30:07 -0500
Received: by mail-vk0-f43.google.com with SMTP id w190so5469522vkd.7
	for <qemu-devel@nongnu.org>; Thu, 07 Dec 2017 10:30:06 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171207202707-mutt-send-email-mst@kernel.org>
References: <20171120142216.17832-1-lprosek@redhat.com>
	<c3c2fa0d-1e93-7f17-f8d3-db8eee82bfd1@redhat.com>
	<CABdb737Evdi0zKEFmkAg1qmp6MqtzX_Gxc=S5-vBbk_m8RNrMw@mail.gmail.com>
	<bdef78d0-2e8a-ac43-dd69-ff9c0ded2712@redhat.com>
	<20171207202707-mutt-send-email-mst@kernel.org>
From: Ladi Prosek <lprosek@redhat.com>
Date: Thu, 7 Dec 2017 19:30:05 +0100
Message-ID: <CABdb7357fgsGWXJ4pU3tQ0=r1-bb_FUku3r8BtYcnT0=aG7v0A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] msix: don't mask already masked vectors on
 reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Marcel Apfelbaum <marcel@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Geoffrey McRae <geoff@hostfission.com>, Alex Williamson <alex.williamson@redhat.com>

On Thu, Dec 7, 2017 at 7:27 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> On Wed, Nov 22, 2017 at 03:22:50PM +0200, Marcel Apfelbaum wrote:
>> On 22/11/2017 14:32, Ladi Prosek wrote:
>> > On Wed, Nov 22, 2017 at 11:46 AM, Marcel Apfelbaum <marcel@redhat.com> wrote:
>> > > Hi Ladi,
>> > >
>> > > On 20/11/2017 16:22, Ladi Prosek wrote:
>> > > >
>> > > > msix_mask_all() is supposed to invoke the release vector notifier if the
>> > > > state of the
>> > > > respective vector changed from unmasked or masked.
>> > >
>> > >
>> > > You mean from unmasked "to" masked right?
>> >
>> > Yes, that's a typo.
>> >
>> > > The way it's currently called from
>> > > >
>> > > > msix_reset(), though, may result in calling the release notifier even if
>> > > > the vector
>> > > > is already masked.
>> > > >
>> > > > 1) msix_reset() clears out the msix_cap field and the msix_table.
>> > > > 2) msix_mask_all() runs with was_masked=false for all vectors because of
>> > > > 1), which
>> > > >      results in calling the release notifier on all vectors.
>> > > > 3) if msix_reset() is subsequently called again, it goes through the same
>> > > > steps and
>> > > >      calls the release notifier on all vectors again.
>> > > >
>> > >
>> > > As far as I can see in the code you are right.(very reset will trigger the
>> > > release notifiers
>> > > again)
>> > >
>> > > > This commit moves msix_mask_all() up so it runs before the device state is
>> > > > lost.
>> > >
>> > >
>> > > OK
>> > >
>> > > > And
>> > > > it adds a call to msix_update_function_masked() so that the device
>> > > > remembers that
>> > > > MSI-X is masked.
>> > > >
>> > >
>> > > msix_update_function_masked checks the msix is enabled or masked-off.
>> > > You are building on the fact the msix will not be enabled to set
>> > > "msix_function_masked" to "true", right?
>> > > (I just want to be sure I understand the patch)
>> >
>> > Correct. msix_enabled() will return false because we've just reset
>> >
>> >    dev->config[dev->msix_cap + MSIX_CONTROL_OFFSET]
>> >
>> > I guess we could also simply assign true to it:
>> >
>> >    dev->msix_function_masked = true;
>> >
>> > just like msix_init() does.
>>
>> Yes, is preferable - I think.
>> If you intend to send V2, please wait first for Alex's remarks if he has any.
>>
>> Thanks,
>> Marcel
>>
>> >
>> > > > This is likely a low impact issue, found while debugging an already broken
>> > > > device. It
>> > > > is however easy to fix and the expectation that the use and release
>> > > > notifier invocations
>> > > > are always balanced is very natural.
>> > > >
>> > >
>> > > I would leave it (maybe) out of 2.11 because it may expose other bugs
>> > > and we are after rc2 already.
>> > >
>> > > Adding Alex Williamson to see it does not affect device assignment,
>> > > other than that the patch looks OK to me.
>> > >
>> > >
>> > > Thanks,
>> > > Marcel
>> > >
>> > >
>> > > > Signed-off-by: Ladi Prosek <lprosek@redhat.com>
>> > > > ---
>> > > >    hw/pci/msix.c | 3 ++-
>> > > >    1 file changed, 2 insertions(+), 1 deletion(-)
>> > > >
>> > > > diff --git a/hw/pci/msix.c b/hw/pci/msix.c
>> > > > index c944c02135..34656de9b0 100644
>> > > > --- a/hw/pci/msix.c
>> > > > +++ b/hw/pci/msix.c
>> > > > @@ -500,11 +500,12 @@ void msix_reset(PCIDevice *dev)
>> > > >            return;
>> > > >        }
>> > > >        msix_clear_all_vectors(dev);
>> > > > +    msix_mask_all(dev, dev->msix_entries_nr);
>> > > >        dev->config[dev->msix_cap + MSIX_CONTROL_OFFSET] &=
>> > > >              ~dev->wmask[dev->msix_cap + MSIX_CONTROL_OFFSET];
>> > > >        memset(dev->msix_table, 0, dev->msix_entries_nr *
>> > > > PCI_MSIX_ENTRY_SIZE);
>> > > >        memset(dev->msix_pba, 0, QEMU_ALIGN_UP(dev->msix_entries_nr, 64) /
>> > > > 8);
>> > > > -    msix_mask_all(dev, dev->msix_entries_nr);
>> > > > +    msix_update_function_masked(dev);
>> > > >    }
>> > > >      /* PCI spec suggests that devices make it possible for software to
>> > > > configure
>> > > >
>> > >
>
> Do you intend to post v2 or need Marcel to?

I'll post v2 tomorrow.
