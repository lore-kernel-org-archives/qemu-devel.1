Received: from eggs.gnu.org ([209.51.188.92]:57647)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1goAl9-0005Yc-EP
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 12:31:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1goAl7-0004zf-IT
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 12:31:47 -0500
Date: Mon, 28 Jan 2019 18:31:24 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190128183124.3d73ac6e.cohuck@redhat.com>
In-Reply-To: <d1f84cbc-2caf-1bd8-8607-79d5a3f9eb6d@linux.ibm.com>
References: <20190121110354.2247-1-cohuck@redhat.com>
	<20190121110354.2247-3-cohuck@redhat.com>
	<2dac6201-9e71-b188-0385-d09d05071a1c@linux.ibm.com>
	<5627cb78-22b3-0557-7972-256bc9560d86@linux.ibm.com>
	<20190125112437.2c06fac6.cohuck@redhat.com>
	<d1f84cbc-2caf-1bd8-8607-79d5a3f9eb6d@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 2/5] vfio-ccw: concurrent I/O handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Farman <farman@linux.ibm.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Alex Williamson <alex.williamson@redhat.com>

On Fri, 25 Jan 2019 15:22:56 -0500
Eric Farman <farman@linux.ibm.com> wrote:

> If we come into mdev_write with state=BUSY and we get the lock, 
> copy_from_user, and do our jump table we go to fsm_io_busy to set 
> ret_code and return -EAGAIN.  Why then don't we set the jump table for 
> state=NOT_OPER||STANDBY to do something that will return -EACCES instead 
> of how we currently do a direct return of -EACCES before all the 
> lock/copy stuff (and the jump table that would take us to fsm_io_error 
> and an error message before returning -EIO)?

If you phrase it like that, I'm wondering why we're not already doing
it that way :) We just need to make sure to revert to the previous
state on error instead of IDLE.
