Received: from eggs.gnu.org ([2001:4830:134:3::10]:41128)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f6wWS-00017t-VZ
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 07:05:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f6wWM-00068J-2Q
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 07:05:38 -0400
Received: from mail-wr0-f179.google.com ([209.85.128.179]:35566)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1f6wWL-00067Z-TE
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 07:05:34 -0400
Received: by mail-wr0-f179.google.com with SMTP id o3so7913256wri.2
	for <qemu-devel@nongnu.org>; Fri, 13 Apr 2018 04:05:33 -0700 (PDT)
References: <20180412095157.GA5004@localhost.localdomain>
	<f30ff8e9-4273-c01b-ae67-5784d5914c7a@redhat.com>
	<20180412111143.GB5004@localhost.localdomain>
	<569800ae-12f8-53f1-012a-50408700ba39@redhat.com>
	<20180412115316.GC5004@localhost.localdomain>
	<306e73f3-9e72-e60f-123c-47a8a72915e2@redhat.com>
	<20180412132735.GD5004@localhost.localdomain>
	<dc693c45-e1dc-5a3d-3c95-adcb946c65d6@redhat.com>
	<20180412142519.GE5004@localhost.localdomain>
	<302b4aea-7e42-a321-f8db-4d0f69794bbf@redhat.com>
	<20180413080105.GA4134@localhost.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a8e995b9-039d-0f0c-25a1-eaa8ee1ea725@redhat.com>
Date: Fri, 13 Apr 2018 13:05:25 +0200
MIME-Version: 1.0
In-Reply-To: <20180413080105.GA4134@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 07/19] block: Really pause
 block jobs on drain
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com, stefanha@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com

On 13/04/2018 10:01, Kevin Wolf wrote:
>> Or bs->quiescent, for the sake of bikeshedding.
> Yes, that sounds better.
> 
> The only problem with the proposal as I made it is that it's wrong. We
> can't keep bs->quiescent until bdrv_do_drained_end() because the caller
> can issue new requests and then have a nested drained section that needs
> to wait for all requests again instead of deciding that everything is
> already quiescent.
> 
> Maybe where we should really reset it is in the initial recursion of
> bdrv_do_drained_begin(), specifically in bdrv_do_drained_begin_quiesce()
> which is called by both the parent and the child recursion.
> 
> There don't seem to be completely obviously correct solutions (can't an
> I/O thread be draining a specific node while the main loop runs
> drain_all?), but this would probably be the most obvious one.

Or use a hash table?

Paolo
