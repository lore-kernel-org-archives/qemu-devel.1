Received: from eggs.gnu.org ([209.51.188.92]:37622)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1h2Bh3-0007fX-Bc
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 04:21:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1h2Bh0-0003Nw-SL
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 04:21:29 -0500
Date: Fri, 8 Mar 2019 10:21:20 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190308102120.14051cc2.cohuck@redhat.com>
In-Reply-To: <5cf175cf-892c-d909-f832-127bf3f4747a@linux.ibm.com>
References: <1551466776-29123-1-git-send-email-jjherne@linux.ibm.com>
	<1551466776-29123-12-git-send-email-jjherne@linux.ibm.com>
	<20190304193509.5eae1b41.cohuck@redhat.com>
	<5cf175cf-892c-d909-f832-127bf3f4747a@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 11/16] s390-bios: cio error handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Jason J. Herne" <jjherne@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, pasic@linux.ibm.com, alifm@linux.ibm.com, borntraeger@de.ibm.com

On Thu, 7 Mar 2019 14:31:23 -0500
"Jason J. Herne" <jjherne@linux.ibm.com> wrote:

> On 3/4/19 1:35 PM, Cornelia Huck wrote:
> > On Fri,  1 Mar 2019 13:59:31 -0500
> > "Jason J. Herne" <jjherne@linux.ibm.com> wrote:
> >   
> >> Add verbose error output for when unexpected i/o errors happen. This eases the
> >> burden of debugging and reporting i/o errors. No error information is printed
> >> in the success case, here is an example of what is output on error:
> >>
> >> cio device error
> >>    ssid  : 0x0000000000000000
> >>    cssid : 0x0000000000000000
> >>    sch_no: 0x0000000000000000
> >>
> >> Interrupt Response Block Data:
> >>      Function Ctrl : [Start]
> >>      Activity Ctrl : [Start-Pending]
> >>      Status Ctrl : [Alert] [Primary] [Secondary] [Status-Pending]
> >>      Device Status : [Unit-Check]
> >>      Channel Status :
> >>      cpa=: 0x000000007f8d6038
> >>      prev_ccw=: 0x0000000000000000
> >>      this_ccw=: 0x0000000000000000
> >> Eckd Dasd Sense Data (fmt 32-bytes):
> >>      Sense Condition Flags :
> >>      Residual Count     =: 0x0000000000000000
> >>      Phys Drive ID      =: 0x000000000000009e
> >>      low cyl address    =: 0x0000000000000000
> >>      head addr & hi cyl =: 0x0000000000000000
> >>      format/message     =: 0x0000000000000008
> >>      fmt-dependent[0-7] =: 0x0000000000000004
> >>      fmt-dependent[8-15]=: 0xe561282305082fff
> >>      prog action code   =: 0x0000000000000016
> >>      Configuration info =: 0x00000000000040e0
> >>      mcode / hi-cyl     =: 0x0000000000000000
> >>      cyl & head addr [0]=: 0x0000000000000000
> >>      cyl & head addr [1]=: 0x0000000000000000
> >>      cyl & head addr [2]=: 0x0000000000000000
> >>
> >> Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
> >> ---
> >>   pc-bios/s390-ccw/cio.c  | 230 ++++++++++++++++++++++++++++++++++++++++++++++++
> >>   pc-bios/s390-ccw/libc.h |  11 +++
> >>   2 files changed, 241 insertions(+)
> >>
> >> diff --git a/pc-bios/s390-ccw/cio.c b/pc-bios/s390-ccw/cio.c
> >> index e61cfd3..c528bbf 100644
> >> --- a/pc-bios/s390-ccw/cio.c
> >> +++ b/pc-bios/s390-ccw/cio.c
> >> @@ -82,6 +82,228 @@ static bool irb_error(Irb *irb)
> >>       return irb->scsw.dstat != (SCSW_DSTAT_DEVEND | SCSW_DSTAT_CHEND);
> >>   }
> >>   
> >> +static void print_eckd_dasd_sense_data(SenseDataEckdDasd *sd)
> >> +{
> >> +    char msgline[512];
> >> +
> >> +    if (sd->config_info & 0x8000) {
> >> +        sclp_print("Eckd Dasd Sense Data (fmt 24-bytes):\n");
> >> +    } else {
> >> +        sclp_print("Eckd Dasd Sense Data (fmt 32-bytes):\n");
> >> +    }
> >> +
> >> +    strcat(msgline, "    Sense Condition Flags :");
> >> +    if (sd->status[0] & SNS_STAT0_CMD_REJECT) {
> >> +        strcat(msgline, " [Cmd-Reject]");
> >> +    }
> >> +    if (sd->status[0] & SNS_STAT0_INTERVENTION_REQ) {
> >> +        strcat(msgline, " [Intervention-Required]");
> >> +    }
> >> +    if (sd->status[0] & SNS_STAT0_BUS_OUT_CHECK) {
> >> +        strcat(msgline, " [Bus-Out-Parity-Check]");
> >> +    }
> >> +    if (sd->status[0] & SNS_STAT0_EQUIPMENT_CHECK) {
> >> +        strcat(msgline, " [Equipment-Check]");
> >> +    }
> >> +    if (sd->status[0] & SNS_STAT0_DATA_CHECK) {
> >> +        strcat(msgline, " [Data-Check]");  
> > 
> > I'm wondering whether it would make sense to factor the common bits
> > out. Might be overkill, though.
> >   
> 
> I'm not huge fan of this error code myself. It looks nice in output and may be useful for 
> debugging which is why I decided to submit it. I did think about ways to make it look 
> cleaner but didn't come up with anything great. I'd be open to suggestions, but I also 
> think going too deep is overkill.
> 
> ...
> > Maybe do basic_sense + print sense data only if there's actually a unit
> > check?
> > 
> > (Also, I'm not sure if you can even do a basic_sense in case e.g. of
> > unexpected busy.)
> >   
> >> +        basic_sense(schid, &sd, sizeof(sd));
> >> +        print_eckd_dasd_sense_data(&sd);
> >>           rc = -1;
> >>           break;
> >>       }  
> 
> I've made a change that should address both issues. Preview:
> 
>          if (cutype == CU_TYPE_DASD_3990 || cutype == CU_TYPE_UNKNOWN) {
>              if (!basic_sense(schid, cutype, &sd, sizeof(sd))) {
>                  print_eckd_dasd_sense_data(&sd);
>              }
>          }
> 
> Now we only print sense data if basic sense works. So if it fails because of a busy status 
> (or any reason) we won't try to print.
> 

Sounds good!
