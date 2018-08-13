Received: from eggs.gnu.org ([2001:4830:134:3::10]:43319)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fpFs7-0004kO-Ux
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 12:39:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fpFs3-00011q-6E
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 12:39:11 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Mon, 13 Aug 2018 12:38:56 -0400
Message-Id: <20180813163859.17964-1-cota@braap.org>
Subject: [Qemu-devel] [PATCH 0/3] convert CPU list to RCU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>, qemu-ppc@nongnu.org

We iterate over the CPU list quite frequently (e.g. with CPU_FOREACH),
but we rarely acquire the cpu_list_lock to do so. This is incorrect,
since the CPU list can be updated (new CPUs added to it) pretty
much anytime, particularly in user-mode.

Instead of grabbing cpu_list_lock everywhere, convert the list to RCU
to that iterations can be safe and wait-free.

Thanks,

		Emilio
