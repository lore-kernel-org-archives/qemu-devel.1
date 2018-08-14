Received: from eggs.gnu.org ([2001:4830:134:3::10]:41461)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fpSnH-0006Fb-PM
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 02:27:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fpSnC-00075S-QI
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 02:27:03 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33993)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fpSnC-000759-Ip
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 02:26:58 -0400
Received: by mail-wm0-f65.google.com with SMTP id l2-v6so9525248wme.1
	for <qemu-devel@nongnu.org>; Mon, 13 Aug 2018 23:26:58 -0700 (PDT)
References: <20180813163859.17964-1-cota@braap.org>
	<20180813163859.17964-4-cota@braap.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <19faab37-6728-b649-488e-c6dc2e5be052@redhat.com>
Date: Tue, 14 Aug 2018 08:26:54 +0200
MIME-Version: 1.0
In-Reply-To: <20180813163859.17964-4-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/3] qom: implement CPU list with an RCU
 QLIST
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>, qemu-ppc@nongnu.org

On 13/08/2018 18:38, Emilio G. Cota wrote:
> 
> Fix it by implementing the CPU list as an RCU QLIST. This requires
> a little bit of extra work to insert CPUs at the tail of
> the list and to iterate over the list in reverse order (see previous patch).
> 
> One might be tempted to just insert new CPUs at the head of the list.
> However, I think this might lead to hard-to-debug issues, since it is
> possible that callers are assuming that CPUs are inserted at the tail
> (just like spapr code did in the previous patch). So instead of auditing
> all callers, this patch simply keeps the old behaviour.

Why not add an RCU_QSIMPLEQ, or even use an array since the quadratic
behavior should not be an issue?  The advantage of the array is that
reverse iteration becomes trivial.

Thanks,

Paolo
