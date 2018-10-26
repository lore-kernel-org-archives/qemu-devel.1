Received: from eggs.gnu.org ([2001:4830:134:3::10]:50099)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1gFyY3-0001LJ-Nj
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 05:36:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1gFyXz-00027v-Iq
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 05:36:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50434)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1gFyXz-00026R-Cj
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 05:36:51 -0400
Date: Fri, 26 Oct 2018 15:06:45 +0530 (IST)
From: P J P <ppandit@redhat.com>
In-Reply-To: <9677a72a-612b-fe4d-cd19-bb5f2e803c58@redhat.com>
Message-ID: <nycvar.YSQ.7.76.1810261325110.8270@xnncv>
References: <20181025200944.12113-1-ppandit@redhat.com>
	<9677a72a-612b-fe4d-cd19-bb5f2e803c58@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH] lsi53c895a: check message length value
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Qemu Developers <qemu-devel@nongnu.org>, Ameya More <ameya.more@oracle.com>, Fam Zheng <famz@redhat.com>

+-- On Fri, 26 Oct 2018, Paolo Bonzini wrote --+
| > -    int msg_len;
| > +    uint8_t msg_len;
| 
| Not wrong per se, but it's also not clear why it's needed.  I understand
| that you want to switch from signed to unsigned, but it is not mentioned
| in the commit message.

Changed to uint8_t because IIUC 'msg_len' is likely be < LSI_MAX_MSGIN_LEN=8. 
And uint32_t seems rather large for it.
 
| The switch to 8-bit, and below from VMSTATE_INT32 to VMSTATE_UINT8, is
| wrong because it changes the format of the live migration stream.

I see.

| I'm not sure it's appropriate to check for out of bounds reads here,
| because if s->msg_len is greater than LSI_MAX_MSGIN_LEN, then this test
| doesn't exclude you've already had an out of bounds write before.
| Indeed the msg_len is checked in lsi_add_msg_byte in order to avoid out
| of bounds accesses in either lsi_add_msg_byte or lsi_do_msgin. You
| could assert here that the variable is in range, I guess.

Okay.

| However, the out of bounds s->msg_len can actually happen in one other
| case: namely, if a malicious live migration stream includes a bogus
| s->msg_len.  Such live migration stream should be rejected; the fix for
| that is to add a lsi_post_load function, point to it in
| vmstate_lsi_scsi, and check there for s->msg_len <= LSI_MAX_MSGIN_LEN.

Okay, sending a revised patch v1 in a bit.

Thank you.
--
Prasad J Pandit / Red Hat Product Security Team
47AF CE69 3A90 54AA 9045 1053 DD13 3D32 FE5B 041F
