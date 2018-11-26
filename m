Received: from eggs.gnu.org ([2001:4830:134:3::10]:43789)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gRNzZ-0002u9-9p
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 16:00:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gRNzV-0004Bc-9B
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 16:00:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36306)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gRNzV-0004BB-2v
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 16:00:25 -0500
Date: Mon, 26 Nov 2018 19:00:21 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20181126210021.GS18284@habkost.net>
References: <20181126152836.25379-1-rkagan@virtuozzo.com>
	<a0ce0395-576b-8175-67ad-7116d021e39e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0ce0395-576b-8175-67ad-7116d021e39e@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] hw/hyperv: fix NULL dereference with
 pure-kvm SynIC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Roman Kagan <rkagan@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Igor Mammedov <imammedo@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>

On Mon, Nov 26, 2018 at 06:13:49PM +0100, Paolo Bonzini wrote:
> On 26/11/18 16:28, Roman Kagan wrote:
> > When started in compat configuration of SynIC, e.g.
> > 
> > qemu-system-x86_64 -machine pc-i440fx-2.10,accel=kvm \
> >  -cpu host,-vmx,hv-relaxed,hv_spinlocks=0x1fff,hv-vpindex,hv-synic
> > 
> > or explicitly
> > 
> > qemu-system-x86_64 -enable-kvm -cpu host,hv-synic,x-hv-synic-kvm-only=on
> > 
> > QEMU crashes in hyperv_synic_reset() trying to access the non-present
> > qobject for SynIC.
> > 
> > Add the missing check for NULL.
> > 
> > Reported-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> > Reported-by: Igor Mammedov <imammedo@redhat.com>
> > Fixes: 9b4cf107b09d18ac30f46fd1c4de8585ccba030c
> > Fixes: 4a93722f9c279184e95b1e1ad775c01deec05065
> > Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
> > ---
> >  hw/hyperv/hyperv.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> > 
> > diff --git a/hw/hyperv/hyperv.c b/hw/hyperv/hyperv.c
> > index a28e7249d8..8758635227 100644
> > --- a/hw/hyperv/hyperv.c
> > +++ b/hw/hyperv/hyperv.c
> > @@ -136,7 +136,11 @@ void hyperv_synic_add(CPUState *cs)
> >  
> >  void hyperv_synic_reset(CPUState *cs)
> >  {
> > -    device_reset(DEVICE(get_synic(cs)));
> > +    SynICState *synic = get_synic(cs);
> > +
> > +    if (synic) {
> > +        device_reset(DEVICE(synic));
> > +    }
> >  }
> >  
> >  static const TypeInfo synic_type_info = {
> > 
> 
> Queued, thanks.

Oops, I had queued it earlier today and just submitted a pull
request.

-- 
Eduardo
