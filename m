Received: from eggs.gnu.org ([2001:4830:134:3::10]:60365)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fRFcU-00069A-OV
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 07:31:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fRFcQ-0006T7-QG
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 07:31:50 -0400
Date: Fri, 8 Jun 2018 13:31:41 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180608133141.15abb227.cohuck@redhat.com>
In-Reply-To: <c9aba2a1-2232-457b-db6d-c2935711231d@redhat.com>
References: <20180607165218.9558-1-david@redhat.com>
	<20180607165218.9558-3-david@redhat.com>
	<20180608093406.30c878ec@bahia.lan>
	<4f518685-fcdb-7c3a-35d3-5a26374e0604@redhat.com>
	<20180608094657.4043502f@bahia.lan>
	<431d4fe5-5bfe-1ab3-00b5-610038a7a9ea@redhat.com>
	<2b431d32-9172-0517-4717-7ce50355b8db@redhat.com>
	<20180608103943.1d7e72ee@redhat.com>
	<673ffa52-1e24-5d6c-5d6a-927d3df79273@redhat.com>
	<20180608110612.18ac915c@redhat.com>
	<9eaefde2-b8aa-9072-610b-4236ce5c3913@redhat.com>
	<20180608125233.46fc187a@bahia.lan>
	<c9aba2a1-2232-457b-db6d-c2935711231d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v1 2/8] spapr: no need to
 verify the node
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: Greg Kurz <groug@kaod.org>, Igor Mammedov <imammedo@redhat.com>, Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, "Michael S . Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Richard Henderson <rth@twiddle.net>

On Fri, 8 Jun 2018 13:28:01 +0200
David Hildenbrand <david@redhat.com> wrote:

> On 08.06.2018 12:52, Greg Kurz wrote:
> > On Fri, 8 Jun 2018 11:24:51 +0200
> > David Hildenbrand <david@redhat.com> wrote:
> >   
> >>>>>> +1 for error_abort, even if it takes another line.      
> >>>>> +1 for error_abort
> >>>>> call shouldn't fail, but if does it won't be silently ignored
> >>>>> and introduce undefined behavior.      
> >>>>
> >>>> Maybe we should fix the others that pass in NULL.
> >>>>
> >>>> (no, not me :D - I'm already busy with your requested pre_plug handling)    
> >>> Add it to wiki page for bite sized tasks?    
> >>
> >> Done.
> >>
> >>  
> > 
> > FWIW, I've also added a line to check and possibly fix places where we do
> > 'if (*errp)', which would cause QEMU to crash if the caller passes NULL.
> > 
> > $ git grep 'if (\*errp)'
> > hmp.c:    if (*errp) {
> > hw/ipmi/isa_ipmi_bt.c:    if (*errp)
> > hw/ipmi/isa_ipmi_kcs.c:    if (*errp)
> > hw/mem/memory-device.c:    if (*errp) {
> > hw/mem/memory-device.c:        if (*errp) {
> > hw/ppc/spapr.c:        if (*errp) {
> > hw/s390x/event-facility.c:        if (*errp) {
> > include/qapi/error.h: *     if (*errp) { // WRONG!
> > qga/commands-posix.c:            if (*errp) {
> > target/s390x/cpu_models.c:    if (*errp) {
> > target/s390x/cpu_models.c:        if (*errp) {
> > target/s390x/cpu_models.c:            if (*errp) {
> > target/s390x/cpu_models.c:        if (*errp) {
> > target/s390x/cpu_models.c:    if (*errp) {
> > target/s390x/cpu_models.c:    if (*errp) {
> > target/s390x/cpu_models.c:    if (*errp) {
> > target/s390x/cpu_models.c:    if (*errp) {
> > target/s390x/cpu_models.c:    if (*errp) {
> > target/s390x/cpu_models.c:    if (*errp) {
> > target/s390x/cpu_models.c:    if (*errp) {
> > target/s390x/cpu_models.c:    if (*errp) {
> > target/s390x/cpu_models.c:    if (*errp) {
> > tests/test-crypto-tlscredsx509.c:    if (*errp) {
> > tests/test-io-channel-tls.c:    if (*errp) {
> >   
> 
> I think the more important part is actually looking out for people that
> use NULL instead of error_abort. This way we won't silently ignore errors.

I think we can assume that the callers here all pass in !NULL. Would
probably make sense to change these anyway because (a) better safe than
sorry, and (b) make sure new code does not copy it.
