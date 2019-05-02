Received: from eggs.gnu.org ([209.51.188.92]:52288)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1hMG2D-0001Fi-GK
	for qemu-devel@nongnu.org; Thu, 02 May 2019 14:02:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1hMG29-0001FP-Pi
	for qemu-devel@nongnu.org; Thu, 02 May 2019 14:02:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47180)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kchamart@redhat.com>) id 1hMG27-00011s-3x
	for qemu-devel@nongnu.org; Thu, 02 May 2019 14:02:11 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BE0F586678
	for <qemu-devel@nongnu.org>; Thu,  2 May 2019 18:02:08 +0000 (UTC)
Date: Thu, 2 May 2019 20:02:01 +0200
From: Kashyap Chamarthy <kchamart@redhat.com>
Message-ID: <20190502180201.GA31376@paraplu>
References: <20180921154323.GS28120@paraplu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180921154323.GS28120@paraplu>
Subject: Re: [Qemu-devel] [RFC] Virtio RNG: Consider changing the default
 entropy source to /dev/urandom?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: nmav@redhat.com, lersek@redhat.com, rjones@redhat.com, armbru@redhat.com

[Reviving this old thread as I don't think we came to a conclusion on
this.]

On Fri, Sep 21, 2018 at 05:43:23PM +0200, Kashyap Chamarthy wrote:
> Hi folks,
> 
> As Markus pointed out in this 'qemu-devel' thread[1],
> backends/rng-random.c uses '/dev/random' in TYPE_RNG_RANDOM's
> instance_init() method:
> 
>     [...]
>     static void rng_random_init(Object *obj)
>     {
>         RngRandom *s = RNG_RANDOM(obj);
>     
>         object_property_add_str(obj, "filename",
>                                 rng_random_get_filename,
>                                 rng_random_set_filename,
>                                 NULL);
>     
>         s->filename = g_strdup("/dev/random");
>         s->fd = -1;
>     }
>     [...]
> 
> And I've looked at hw/virtio/virtio-rng.c:
> 
>     [...]
>     static void virtio_rng_device_realize(DeviceState *dev, Error **errp)
>     {
>     [...]
>     
>         if (vrng->conf.rng == NULL) {
>             vrng->conf.default_backend = RNG_RANDOM(object_new(TYPE_RNG_RANDOM));
>     [...]
> 
> From the above, I'm assuming QEMU uses `/dev/random` as the _default_
> entropy source for a 'virtio-rng-pci' device.  If my assumption is
> correct, any reason why not to change the default entropy source for
> 'virtio-rng-pci' devices to `/dev/urandom` (which is the preferred[2]
> source of entropy)?
> 
> And I understand (thanks: Eric Blake for correcting my confusion) that
> there are two cases to distinguish:
> 
> (a) When QEMU needs a random number, the entropy source it chooses.
>     IIUC, the answer is: QEMU defers to GnuTLS by default, which uses
>     getrandom(2), which in turn uses '/dev/urandom' as its entropy
>     source; if getrandom(2) isn't available, GnuTLS uses `/dev/urandom`
>     anyway.  (Thanks: Nikos for clarifying this.)
> 
>     If QEMU is built with GnuTLS _disabled_, which I'm not sure if any
>     Linux distribution does, then it uses libgcrypt, which in turn uses
>     the undesired and legacy `/dev/random` as the default entropy
>     source.
> 
> (b) When QEMU exposes a Virtio RNG device to the guest, that device
>     needs a source of entropy, and IIUC, that source needs to be
>     "non-blocking" (i.e. `/dev/urandom`).  However, currently QEMU
>     defaults to the problematic `/dev/random`.
> 
> I'd like to get some more clarity on case (b).  
> 
> 
> [1] https://lists.nongnu.org/archive/html/qemu-devel/2018-06/msg08335.html
>     -- RNG: Any reason QEMU doesn't default to `/dev/urandom`
> 
> [2] http://man7.org/linux/man-pages/man4/urandom.4.html
> 
> 
> -- 
> /kashyap
> 

-- 
/kashyap
