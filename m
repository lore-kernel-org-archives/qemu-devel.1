Received: from eggs.gnu.org ([2001:4830:134:3::10]:60466)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1eM67O-0001Rj-Ll
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 00:50:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1eM67M-0007m7-3G
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 00:50:10 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53270)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bjsdjshi@linux.vnet.ibm.com>)
	id 1eM67L-0007lr-QE
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 00:50:08 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vB55nP7d103495
	for <qemu-devel@nongnu.org>; Tue, 5 Dec 2017 00:50:03 -0500
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2enndf8f18-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 05 Dec 2017 00:50:02 -0500
Received: from localhost
	by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bjsdjshi@linux.vnet.ibm.com>;
	Tue, 5 Dec 2017 00:50:01 -0500
Date: Tue, 5 Dec 2017 13:49:56 +0800
From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
References: <20171201143136.62497-1-pasic@linux.vnet.ibm.com>
	<20171201143136.62497-3-pasic@linux.vnet.ibm.com>
	<20171204121511.0abe9ca2.cohuck@redhat.com>
	<f237126d-0815-8433-6ef7-1c1ba2e5a956@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f237126d-0815-8433-6ef7-1c1ba2e5a956@linux.vnet.ibm.com>
Message-Id: <20171205054956.GY5859@bjsdjshi@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 2/3] s390x/css: advertise unrestricted
 cssids
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, Shalini Chellathurai Saroja <shalini@linux.vnet.ibm.com>, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, Boris Fiuczynski <fiuczy@linux.vnet.ibm.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>

* Halil Pasic <pasic@linux.vnet.ibm.com> [2017-12-04 16:07:27 +0100]:

> 
> 
> On 12/04/2017 12:15 PM, Cornelia Huck wrote:
> > On Fri,  1 Dec 2017 15:31:35 +0100
> > Halil Pasic <pasic@linux.vnet.ibm.com> wrote:
> > 
> >> Let us advertise the changes introduced by "s390x/css: unrestrict cssids"
> >> to the management software (so it can tell are cssids unrestricted or
> >> restricted).
> >>
> >> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> >> ---
> >>
> >> Boris says having the property on the virtual-css-bridge is good form
> >> Libvirt PoV. @Shalini: could you verify that things work out fine
> >> (provided we get at least a preliminary blessing from Connie).
> >>
> >> Consider squashing into "s390x/css: unrestrict cssids".
> >> ---
> >>  hw/s390x/css-bridge.c | 11 +++++++++++
> >>  1 file changed, 11 insertions(+)
> >>
> >> diff --git a/hw/s390x/css-bridge.c b/hw/s390x/css-bridge.c
> >> index c4a9735d71..c7e8998680 100644
> >> --- a/hw/s390x/css-bridge.c
> >> +++ b/hw/s390x/css-bridge.c
> >> @@ -123,6 +123,11 @@ static Property virtual_css_bridge_properties[] = {
> >>      DEFINE_PROP_END_OF_LIST(),
> >>  };
> >>  
> >> +static bool prop_get_true(Object *obj, Error **errp)
> >> +{
> >> +    return true;
> >> +}
> >> +
> >>  static void virtual_css_bridge_class_init(ObjectClass *klass, void *data)
> >>  {
> >>      HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(klass);
> >> @@ -131,6 +136,12 @@ static void virtual_css_bridge_class_init(ObjectClass *klass, void *data)
> >>      hc->unplug = ccw_device_unplug;
> >>      set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
> >>      dc->props = virtual_css_bridge_properties;
> >> +    object_class_property_add_bool(klass, "cssid-unrestricted",
> >> +                                   prop_get_true, NULL, NULL);
> >> +    object_class_property_set_description(klass, "cssid-unrestricted",
> >> +            "A css device can use any  cssid, regardless whether virtual"
> > 
> > extra space -----------------------------^
> > 
> 
> Nod.
> 
> >> +            " or not (read only, always true)",
> 
> Do we need "." here ----------------------------^ ?
> 
> >> +            NULL);
> >>  }
> >>  
> >>  static const TypeInfo virtual_css_bridge_info = {
> > 
> > Looks reasonable. If this works as expected, I'll squash it into the
> > previous patch.
> > 
> 
> I've just asked Shalini to verify the libvirt perspective.
> 
> Supposed we verify this works as expected, I read I don't have to spin
> a v2 and you are going to fix the issues found yourself. Right?
Supposed this works as expected, you have my r-b. ;)

-- 
Dong Jia Shi
