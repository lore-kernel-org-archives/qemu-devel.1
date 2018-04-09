Received: from eggs.gnu.org ([2001:4830:134:3::10]:34583)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1f5Wqk-0006es-4V
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 09:28:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1f5Wqg-0006kL-5g
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 09:28:46 -0400
References: <20180409130700.5692-1-david@redhat.com>
	<7688fe59-e20a-2de6-d805-6dc53893a326@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <dbb9acdd-71ad-1fd6-e6c4-d964cb28f763@redhat.com>
Date: Mon, 9 Apr 2018 15:28:31 +0200
MIME-Version: 1.0
In-Reply-To: <7688fe59-e20a-2de6-d805-6dc53893a326@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1] cpus: track calls to
 resume/pause_all_vcpus()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Richard Henderson <rth@twiddle.net>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>

On 09.04.2018 15:12, Paolo Bonzini wrote:
> On 09/04/2018 15:07, David Hildenbrand wrote:
>> If we have parallel calls to resume/pause_all_vcpus() we can get
>> into trouble because the qemu mutex is temporarily dropped while
>> waiting for all threads to stop. This can happen e.g. for s390x, where
>> resume/pause_all_vcpus() can be triggered by a VCPU.
>=20

I'm also using it resume/pause_all_vcpus() now in a prototype to
temporarily get all VCPUs out of KVM, that's how I noticed that this is
shaky :)

> Why does s390 need to do pause_all_vcpus()/resume_all_vcpus() instead o=
f
> just asking the main thread to do it (similar to qemu_system_reset), is
> it because diag 308 must be synchronous?

Christian implemented it back than to (quoting from another mail)

"I did this to prevent a "still running CPU to restart an already
stopped one"."

The problem is that another VCPU could just be about to send a SIGP
START/RESTART to a VCPU. Without the pause_all_vcpus(), the SIGP could
be delayed and executed just after the "soft reset", therefore resulting
in more than 1 VCPU running.

>=20
> One disadvantage of the current approach is that diag 308 does not obey
> -no-reboot.

Both calls are used for kdump+kexec. "kdump on s390 uses a load normal
reset to bring the system in a defined state by doing a subsystem
reset", so like a "soft reboot". I don't think that we want to apply
"-no-reboot" here.

>=20
> Paolo
>=20


--=20

Thanks,

David / dhildenb
