Received: from eggs.gnu.org ([2001:4830:134:3::10]:42115)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eoSfE-00018S-Hc
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 06:34:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eoSfB-0002wU-Ec
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 06:34:20 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52880 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eoSfB-0002wG-9m
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 06:34:17 -0500
References: <1519208316-18812-1-git-send-email-thuth@redhat.com>
	<556ae8d1-bb6c-d9cc-2b2b-d28fad96aa7b@ilande.co.uk>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <525b685f-597c-02c0-0f16-a6ffd6016968@redhat.com>
Date: Wed, 21 Feb 2018 12:34:06 +0100
MIME-Version: 1.0
In-Reply-To: <556ae8d1-bb6c-d9cc-2b2b-d28fad96aa7b@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 0/7] Improvements and clean-ups related
 to -net
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On 21/02/2018 11:41, Mark Cave-Ayland wrote:
> 1) Does the new -nic syntax support multiple on-board NICs? I remember
> seeing this on some of the ARM boards I was studying when trying to
> implement something similar for SPARC.

Yes, but they will be in different subnets if you do "-nic user -nic
user".  If you want to put them on the same trunk, what you want is
(cut-and-pasted from an offlist email from Thomas):

     -netdev user,id=3Dslirp \
     -netdev hubport,id=3Dport,netdev=3Dslirp,hubid=3D0 \
     -nic hubport,hubid=3D0 \
     -nic hubport,hubid=3D0

We could make id and hubid optional (id was already optional in -net so
the logic is there already, see assign_name in net/net.c), giving the
much nicer:

     -netdev user,id=3Dslirp \
     -netdev hubport,netdev=3Dslirp \
     -nic hubport \
     -nic hubport

Thanks,

Paolo

> 2) Is it possible to provide a convenient wrapper function to handle th=
e
> logic related to determining whether a specified NIC is on-board or not=
?
