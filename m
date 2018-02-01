Received: from eggs.gnu.org ([2001:4830:134:3::10]:38188)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ehIef-000299-3v
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 12:28:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ehIea-0004mK-7T
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 12:28:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57389)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ehIeZ-0004lq-Uu
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 12:28:04 -0500
Date: Thu, 1 Feb 2018 17:27:09 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180201172709.GJ2457@work-vm>
References: <20180129174132.108925-1-brijesh.singh@amd.com>
	<20180129174132.108925-19-brijesh.singh@amd.com>
	<20180130200838.GB2319@work-vm>
	<0abe3fee-a970-dc82-fd92-ad923bfa863a@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <0abe3fee-a970-dc82-fd92-ad923bfa863a@amd.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 18/23] sev: emit the SEV_MEASUREMENT
 event
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Brijesh Singh <brijesh.singh@amd.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, Tom Lendacky <Thomas.Lendacky@amd.com>, Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>, Eduardo Habkost <ehabkost@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, Eric Blake <eblake@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>

* Brijesh Singh (brijesh.singh@amd.com) wrote:
>=20
>=20
> On 1/30/18 2:08 PM, Dr. David Alan Gilbert wrote:
> > * Brijesh Singh (brijesh.singh@amd.com) wrote:
> >> During machine creation we encrypted the guest bios image, the
> >> LAUNCH_MEASURE command can be used to retrieve the measurement of
> >> the encrypted memory region. Emit the SEV_MEASUREMENT event so that
> >> libvirt can grab the measurement value as soon as we are done with
> >> creating the encrypted machine.
> > Can you ust clarify what happens if the libvirt has disconnected and
> > reconnected to qemu and so didn't see the event?  Can the reconnectin=
g
> > libvirt query it and find out it's ready/not ready yet?
>=20
> Dave,
>=20
> I have not looked into details between libvirt and qemu interaction to
> comment how and when the events will be delivered. Recently, one of my
> colleague was implementing libvirt interface for the SEV guest and ran
> into somewhat a similar challenge and posted question on libvirt mailin=
g
> list [1].
>=20
> In previous discussion on qemu mailing list, we agreed to implement SEV
> MEASUREMENT event which can be seen by libvirt. That's what this patch
> is doing.
>=20
> But during the libvirt implementation it seems that qemu monitor
> silently drops all the events before it get the first qmp_capabilities
> command. At a quick glance it seems on reconnect, libvirt issues
> qmp_capabilities command and any event issued before the
> qmp_capabilities command will never to delivered to libvirt. we are
> looking for=A0 help from libvirt/qemu monitor experts on how we solve t=
his
> problem. Our goal is to provide the measurement to libvirt before
> libvirt issues "continue" command. Since event can't be seen by libvirt
> before it resumes the guest hence I was wondering if we should we shoul=
d
> drop the SEV measurement event and consider adding a new QMP command to
> query the SEV measurement.

Yep, I'll leave it to the libvirt contacts for the best way they'd like
to see that, as Eric says there's nothing wrong with having both the
command and event if useful.  Also keep in mind coping with a guest that
crashes early or that measurement never arrives.

Dave

> [1] https://www.redhat.com/archives/libvir-list/2018-January/msg00602.h=
tml
>=20
> > Dave
> >
> >> Cc: Daniel P. Berrange <berrange@redhat.com>
> >> Cc: Paolo Bonzini <pbonzini@redhat.com>
> >> Cc: kvm@vger.kernel.org
> >> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> >> ---
> >>  accel/kvm/sev.c        | 58 +++++++++++++++++++++++++++++++++++++++=
+++++++++++
> >>  accel/kvm/trace-events |  1 +
> >>  include/sysemu/sev.h   |  1 +
> >>  3 files changed, 60 insertions(+)
> >>
> >> diff --git a/accel/kvm/sev.c b/accel/kvm/sev.c
> >> index 1f757df725df..b78cf3144b1d 100644
> >> --- a/accel/kvm/sev.c
> >> +++ b/accel/kvm/sev.c
> >> @@ -19,11 +19,13 @@
> >>  #include "sysemu/sev.h"
> >>  #include "sysemu/sysemu.h"
> >>  #include "trace.h"
> >> +#include "qapi-event.h"
> >> =20
> >>  #define DEFAULT_GUEST_POLICY    0x1 /* disable debug */
> >>  #define DEFAULT_SEV_DEVICE      "/dev/sev"
> >> =20
> >>  static int sev_fd;
> >> +static SEVState *sev_state;
> >> =20
> >>  #define SEV_FW_MAX_ERROR      0x17
> >> =20
> >> @@ -418,6 +420,59 @@ err:
> >>      return ret;
> >>  }
> >> =20
> >> +static void
> >> +sev_launch_get_measure(Notifier *notifier, void *unused)
> >> +{
> >> +    int ret, error;
> >> +    guchar *data;
> >> +    SEVState *s =3D sev_state;
> >> +    struct kvm_sev_launch_measure *measurement;
> >> +
> >> +    measurement =3D g_malloc0(sizeof(*measurement));
> >> +    if (!measurement) {
> >> +        return;
> >> +    }
> >> +
> >> +    /* query the measurement blob length */
> >> +    ret =3D sev_ioctl(KVM_SEV_LAUNCH_MEASURE, measurement, &error);
> >> +    if (!measurement->len) {
> >> +        error_report("%s: LAUNCH_MEASURE ret=3D%d fw_error=3D%d '%s=
'",
> >> +                     __func__, ret, error, fw_error_to_str(errno));
> >> +        goto free_measurement;
> >> +    }
> >> +
> >> +    data =3D g_malloc(measurement->len);
> >> +    if (s->measurement) {
> >> +        goto free_data;
> >> +    }
> >> +
> >> +    measurement->uaddr =3D (unsigned long)data;
> >> +
> >> +    /* get the measurement blob */
> >> +    ret =3D sev_ioctl(KVM_SEV_LAUNCH_MEASURE, measurement, &error);
> >> +    if (ret) {
> >> +        error_report("%s: LAUNCH_MEASURE ret=3D%d fw_error=3D%d '%s=
'",
> >> +                     __func__, ret, error, fw_error_to_str(errno));
> >> +        goto free_data;
> >> +    }
> >> +
> >> +    sev_set_guest_state(SEV_STATE_SECRET);
> >> +
> >> +    /* encode the measurement value and emit the event */
> >> +    s->measurement =3D g_base64_encode(data, measurement->len);
> >> +    trace_kvm_sev_launch_measurement(s->measurement);
> >> +    qapi_event_send_sev_measurement(s->measurement, &error_abort);
> >> +
> >> +free_data:
> >> +    g_free(data);
> >> +free_measurement:
> >> +    g_free(measurement);
> >> +}
> >> +
> >> +static Notifier sev_machine_done_notify =3D {
> >> +    .notify =3D sev_launch_get_measure,
> >> +};
> >> +
> >>  void *
> >>  sev_guest_init(const char *id)
> >>  {
> >> @@ -461,6 +516,9 @@ sev_guest_init(const char *id)
> >>      }
> >> =20
> >>      ram_block_notifier_add(&sev_ram_notifier);
> >> +    qemu_add_machine_init_done_notifier(&sev_machine_done_notify);
> >> +
> >> +    sev_state =3D s;
> >> =20
> >>      return s;
> >>  err:
> >> diff --git a/accel/kvm/trace-events b/accel/kvm/trace-events
> >> index c55546f36a25..51df5113ad07 100644
> >> --- a/accel/kvm/trace-events
> >> +++ b/accel/kvm/trace-events
> >> @@ -20,3 +20,4 @@ kvm_memcrypt_unregister_region(void *addr, size_t =
len) "addr %p len 0x%lu"
> >>  kvm_sev_change_state(char *old, char *new) "%s -> %s"
> >>  kvm_sev_launch_start(int policy, void *session, void *pdh) "policy =
0x%x session %p pdh %p"
> >>  kvm_sev_launch_update_data(void *addr, uint64_t len) "addr %p len 0=
x%" PRIu64
> >> +kvm_sev_launch_measurement(const char *value) "data %s"
> >> diff --git a/include/sysemu/sev.h b/include/sysemu/sev.h
> >> index 839800efdbbf..572120c865ea 100644
> >> --- a/include/sysemu/sev.h
> >> +++ b/include/sysemu/sev.h
> >> @@ -63,6 +63,7 @@ typedef enum {
> >> =20
> >>  struct SEVState {
> >>      QSevGuestInfo *sev_info;
> >> +    gchar *measurement;
> >>  };
> >> =20
> >>  typedef struct SEVState SEVState;
> >> --=20
> >> 2.9.5
> >>
> > --
> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
